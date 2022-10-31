Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAC7E
	for <damon@lists.linux.dev>; Mon, 31 Oct 2022 01:44:36 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso7256377iob.20
        for <damon@lists.linux.dev>; Sun, 30 Oct 2022 18:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+x43YHymMfhOhP0Yr9kyHS3xoVOJdfu9fMG1zeZbz0=;
        b=w6NXbKuQAZCb5Xxuym03jVVBGFWtyOn3tzNXmxNCA8VBf5jJ72TvMDXCiUTwOfwCeg
         9UTKPb2vA2NxEtL1uHPoix+3t8fxNxKSJ5d2mEN1+i5NYvlX0WIkSkaCWcxIeWtmynPH
         4aTM0l3xx1M0xdKMajFtxI43SmnfxPqzl5W5+KYsiQmwBqqlh1x7vYFASyd5STemOmXr
         DUA2oc/FBBN/se2n3WLOW+kJUh+WkjSnn5Ak07EZkHgf9pbdXTIUWiayYLFcS+UzFFuJ
         rIvcDlIGDX+sgiY/pUmRvEQ318sxYrAummVPT7/Sz/uiqV+wixEbIpxF0NCgdK4Od/Ql
         MwQw==
X-Gm-Message-State: ACrzQf2rvpxiemjlrVzMAIaTccDvK5b2tuYTnOnYudMSsyEQ6udiuvK5
	KwxqoRWmxwyjoaEKHRh3Hpkvyj19FY5tQ93IXtoujW9Vwt2G
X-Google-Smtp-Source: AMsMyM5G3dQRwEa1dCZBG9Y0WUp0xHJrMupoJB8PiNNlqB/6X8tX07in5+lhxBd7KAGJDStyD1FRSlIopmbaa2Znvdrma7i3rKf6
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:3652:0:b0:2df:4133:787 with SMTP id
 d18-20020a923652000000b002df41330787mr5505875ilf.39.1667180675324; Sun, 30
 Oct 2022 18:44:35 -0700 (PDT)
Date: Sun, 30 Oct 2022 18:44:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ede3ac05ec4abf8e@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Write in dbgfs_rm_context_write
From: syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12508922880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=6087eafb76a94c4ac9eb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167e3f4a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262cb86880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9ab8f713204/disk-98555239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5efa1b178038/vmlinux-98555239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83329b87f1a8/bzImage-98555239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 3603 Comm: syz-executor414 Not tainted 6.1.0-rc2-syzkaller-00078-g98555239e4c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:928 [inline]
RIP: 0010:dbgfs_rm_context_write+0x2e3/0x4d0 mm/damon/dbgfs.c:971
Code: 00 4d 8b 36 4c 39 34 24 0f 84 e4 00 00 00 e8 34 c3 a7 ff 48 8b 44 24 18 49 63 d4 48 c1 e2 03 48 8d 34 10 48 89 f7 48 c1 ef 03 <80> 3c 2f 00 0f 85 6b 01 00 00 48 8b 05 2c 85 52 0f 4c 89 36 41 83
RSP: 0018:ffffc90003d3fcb0 EFLAGS: 00010202
RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88806f180000 R14: ffff88801b67a468 R15: 0000000000000000
FS:  00005555559df300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 000000007e9a6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 full_proxy_write+0x118/0x180 fs/debugfs/file.c:236
 vfs_write+0x2d7/0xdd0 fs/read_write.c:582
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4ee923dd69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd47563a18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4ee923dd69
RDX: 000000000000fe6c RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f4ee9201f10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4ee9201fa0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:928 [inline]
RIP: 0010:dbgfs_rm_context_write+0x2e3/0x4d0 mm/damon/dbgfs.c:971
Code: 00 4d 8b 36 4c 39 34 24 0f 84 e4 00 00 00 e8 34 c3 a7 ff 48 8b 44 24 18 49 63 d4 48 c1 e2 03 48 8d 34 10 48 89 f7 48 c1 ef 03 <80> 3c 2f 00 0f 85 6b 01 00 00 48 8b 05 2c 85 52 0f 4c 89 36 41 83
RSP: 0018:ffffc90003d3fcb0 EFLAGS: 00010202
RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88806f180000 R14: ffff88801b67a468 R15: 0000000000000000
FS:  00005555559df300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561931b2a098 CR3: 000000007e9a6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 4d 8b             	add    %cl,-0x75(%rbp)
   3:	36 4c 39 34 24       	cmp    %r14,%ss:(%rsp)
   8:	0f 84 e4 00 00 00    	je     0xf2
   e:	e8 34 c3 a7 ff       	callq  0xffa7c347
  13:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  18:	49 63 d4             	movslq %r12d,%rdx
  1b:	48 c1 e2 03          	shl    $0x3,%rdx
  1f:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
  23:	48 89 f7             	mov    %rsi,%rdi
  26:	48 c1 ef 03          	shr    $0x3,%rdi
* 2a:	80 3c 2f 00          	cmpb   $0x0,(%rdi,%rbp,1) <-- trapping instruction
  2e:	0f 85 6b 01 00 00    	jne    0x19f
  34:	48 8b 05 2c 85 52 0f 	mov    0xf52852c(%rip),%rax        # 0xf528567
  3b:	4c 89 36             	mov    %r14,(%rsi)
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
