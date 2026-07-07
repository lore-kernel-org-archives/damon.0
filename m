Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7FE38911F
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459984; cv=none; b=WJIKqsGRCW2j7uKgOovEjxhTukn2EGFQFjH2DzXn4yuJaFOwFFc3ArLpwa0A25nb1POw0wTL6pfEenbnNPwIOl4GfISEXiL74+x6+EgWm7kYFlQS2+EEyf/f8e+uo925Snak0DL5MNSZs1RCmuNX6ajKoe3WtOpNC8onl4jR20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459984; c=relaxed/simple;
	bh=jEqvd4EuPiFtruMx0AmvgitV0rlHUlhXdIoQyGq9uo0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hjrqqG2gFnkxRMUyaJ/xY2cEmj9BHD0h1InCLB4H5trlyrbo5H/wplmzKAWsI/pLhcpbJdPhtWw8aixunIuuX7M1wQqLh7VMQoE6DNzWsNXUW7B4Ku9yUf2BFvLuDJhuLQgX3swH5OlMm9zfg5qKtC0i+D1F1apK09UC7h4WPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9fa2cd5c9so77456a34.2
        for <damon@lists.linux.dev>; Tue, 07 Jul 2026 14:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783459979; x=1784064779;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZbjaYNNT/DAa2ZgxKUTDH5wk4uWoo8h75GUG/OWPB4w=;
        b=O/qDk0RB9O3f6JoPCBsZHuRDbFroOZBWU53/E5/N7vhofE0GicO8EpU2s1NYf0NvYt
         5yXYQCP1LD14O0af9u8VZxtXrD88cHnccSewqkpbYtFsGGf0y0Td6gr/z6MssSYAlI0Q
         kpvsYBYU75AFvc4d7OJZAvMEfeLV94OdCZ0jl2RO0ehAlFOb7HMqpAO+lMXT16nq2Vvq
         irNPMwcOnvmcVwCEJ/bsJdBh7YeHFkvEuDPv7t5xOlQdJZVmmGCICIqhq525miQJ5gyX
         olWTju+zXuBGeNFqKNEhHw3UyPaKlY51Rv9k+bFMWsIpzQPD8gLW4MH9FHufa1Wl5maZ
         5sNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fSKhrCAkTPqp0ZmWnEuQBqCBhuHmszlTf4hTKF0Bm2y+A78yVJPbgkOq6i0T2PRX2RiXKBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjp/ovf/OFmib2VHE5aU27fKdkKWqhtNVJ0ArJ4kWBJXqd7pCS
	ehsN+KZNeNTnTDMwfGbU3RgeTM61pmIhi5yATGwZk/DcN0zEWUOm7FbSB+Zf6T5Jj480Sdr+TWw
	kAzn4kxzkcqtdRKvEsbrgwRUT10dE5vDTSp7JN7tyhbxzvBGuGhHtHu8qXwQ=
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1995:b0:6a1:5ca0:d52e with SMTP id
 006d021491bc7-6a355246c2emr4441088eaf.7.1783459978731; Tue, 07 Jul 2026
 14:32:58 -0700 (PDT)
Date: Tue, 07 Jul 2026 14:32:58 -0700
In-Reply-To: <20260707063308.29176-1-tao.wangtao@honor.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4d708a.a1ad617e.25832.000c.GAE@google.com>
Subject: [syzbot ci] Re: mm: rework anon_vma and remove anon_vma_chain
From: syzbot ci <syzbot+cie73eac57e65eaf28@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, bp@alien8.de, 
	byungchul@sk.com, catalin.marinas@arm.com, chengming.zhou@linux.dev, 
	damon@lists.linux.dev, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, dvander@google.com, gourry@gourry.net, harry@kernel.org, 
	hpa@zytor.com, jack@suse.cz, jannh@google.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, joshua.hahnjy@gmail.com, jparsana@google.com, 
	kas@kernel.org, kees@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	luizcap@redhat.com, matthew.brost@intel.com, mhocko@suse.com, 
	mingo@redhat.com, muchun.song@linux.dev, nao.horiguchi@gmail.com, 
	npache@redhat.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, ryncsn@gmail.com, 
	shakeel.butt@linux.dev, sj@kernel.org, surenb@google.com, 
	tao.wangtao@honor.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] mm: rework anon_vma and remove anon_vma_chain
https://lore.kernel.org/all/20260707063308.29176-1-tao.wangtao@honor.com
* [RFC PATCH v2 01/13] mm: add CONFIG_ANON_VMA_FRACTAL
* [RFC PATCH v2 02/13] mm: implement helpers for ANON_VMA_FRACTAL
* [RFC PATCH v2 03/13] mm: implement __anon_node_prepare for ANON_VMA_FRACTAL
* [RFC PATCH v2 04/13] mm: implement anon_node_clone for ANON_VMA_FRACTAL
* [RFC PATCH v2 05/13] mm: implement anon_node_fork_with_prev for ANON_VMA_FRACTAL
* [RFC PATCH v2 06/13] mm: implement unlink_anon_nodes for ANON_VMA_FRACTAL
* [RFC PATCH v2 07/13] mm: handle rmap_base changes for ANON_VMA_FRACTAL
* [RFC PATCH v2 08/13] mm: implement anonymous folio rmap for ANON_VMA_FRACTAL
* [RFC PATCH v2 09/13] mm: prepare anon_node replacement for ANON_VMA_FRACTAL
* [RFC PATCH v2 10/13] mm: replace anon_vma with anon_node for ANON_VMA_FRACTAL
* [RFC PATCH v2 11/13] mm: optimize rmap for ANON_VMA_FRACTAL with PVL
* [RFC PATCH v2 12/13] mm: shared semaphores for ANON_VMA_FRACTAL
* [RFC PATCH v2 13/13] mm: Enable CONFIG_ANON_VMA_FRACTAL by default

and found the following issue:
WARNING: bad unlock balance in exc_page_fault

Full report is available here:
https://ci.syzbot.org/series/39466cf1-707b-420e-8f1e-11735bea6c66

***

WARNING: bad unlock balance in exc_page_fault

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      8ff49efd1cf18086320f3b43d1bd483c0b9e7e58
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/c3a229e4-b949-4889-b309-dbdd1fadd95f/config
syz repro: https://ci.syzbot.org/findings/29b52ad4-b463-41da-877c-4138356e3960/syz_repro

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
sshd/5593 is trying to release lock (vm_lock) at:
[<ffffffff8bb5032a>] handle_page_fault arch/x86/mm/fault.c:1483 [inline]
[<ffffffff8bb5032a>] exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
but there are no more locks to release!

other info that might help us debug this:
no locks held by sshd/5593.

stack backtrace:
CPU: 1 UID: 0 PID: 5593 Comm: sshd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5527 [inline]
 lock_release+0x1f1/0x3c0 kernel/locking/lockdep.c:5889
 vma_refcount_put include/linux/mmap_lock.h:216 [inline]
 vma_end_read include/linux/mmap_lock.h:264 [inline]
 do_user_addr_fault+0xab0/0x1340 arch/x86/mm/fault.c:1345
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0033:0x5583206de68b
Code: 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 89 e2 e8 8c 5b ff ff 85 c0 78 13 31 c0 4d 85 e4 74 0c 48 8b 3c 24 48 89 de 4c 89 e1 <f3> a4 48 8b 54 24 08 64 48 2b 14 25 28 00 00 00 74 05 e8 5e 17 fc
RSP: 002b:00007fff02a37e60 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 000055835a20d6fe RCX: 0000000000008000
RDX: 0000000000000000 RSI: 000055835a20d6fe RDI: 00007fac5106c010
RBP: 000055832073df00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000008000
R13: 000000000000005e R14: 00000000000000b3 R15: 00007fff02a37f88
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
