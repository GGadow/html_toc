var TOCState = 'block';

function ShowHideToc() {
    TOCState = (TOCState == 'none') ? 'block' : 'none';
    var newText = (TOCState == 'none') ? 'Show' : 'Hide';
    document.getElementById('__toc_toggle').innerHTML = newText;
    document.getElementById('__toc_content').style.display = TOCState;
}
