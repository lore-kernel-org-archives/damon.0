Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE613AFA
	for <damon@lists.linux.dev>; Fri,  8 Sep 2023 18:04:30 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a2d9a6b5fso3321446b3a.0
        for <damon@lists.linux.dev>; Fri, 08 Sep 2023 11:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196270; x=1694801070;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lAvPiHpQzYJH2/Evbqeae0jEIobBXd5mkIT/JR5mjU=;
        b=ZH9PagDBIruxlljlq73vx/P1f4wBjb9omLfSgrcEk2MaJt1J4Vrzfr6k2nNumYCOHr
         xS5wci0byWrJsmcy0zID8yJH15wBASVzHr9ZRuyTBBUR/jcXOrgrRlYEXw+E3/D/s8pc
         TU7SAu67b/0WJYoaEqIBULhRYI6ITw3PXVcKvL7xA3/BBz0D6lucn+UJGN0/fPBI37gp
         RWaL5G9uTcIec8WzG+ycea4yjpslx11xA20wfuQrnn170c0Zr9edc/xAaLTTqPSeg4gT
         JzIcGYWubtuvBNiOE44Nb56XvQMhDzgVLt148PmCe06lxygB7k8VR6RCBHRpDu+1lFct
         BIcw==
X-Gm-Message-State: AOJu0YwhvQXPgELSIZ58Ta9lxz45MDfVR/4cSwHfyyxKt1B4uKkB25o8
	5q8YMNJFFmPjbChyMOfJolSnf1TaGcNFNJQQZbVOWn3gMkVy
X-Google-Smtp-Source: AGHT+IFG6oZqBOayFovKE0NVKEQ0Xnwtd+Nskzg2qKPXIoko6vfMv+elInHkBKWJh6QlQckbllDdPD2ESA+Mlnx+N1cgB86kBYBd
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:80c:b0:68a:3c7a:128c with SMTP id
 m12-20020a056a00080c00b0068a3c7a128cmr1357477pfk.2.1694196270440; Fri, 08 Sep
 2023 11:04:30 -0700 (PDT)
Date: Fri, 08 Sep 2023 11:04:30 -0700
In-Reply-To: <000000000000f392a60604a65085@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e127ec0604dcce27@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
From: syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, Liam.Howlett@Oracle.com, agordeev@linux.ibm.com, 
	akpm@linux-foundation.org, alexghiti@rivosinc.com, aou@eecs.berkeley.edu, 
	borntraeger@linux.ibm.com, cgroups@vger.kernel.org, 
	christophe.leroy@csgroup.eu, damon@lists.linux.dev, david@redhat.com, 
	eadavis@sina.com, frankja@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	gor@linux.ibm.com, hannes@cmpxchg.org, hca@linux.ibm.com, 
	imbrenda@linux.ibm.com, jeeheng.sia@starfivetech.com, jglisse@redhat.com, 
	kvm@vger.kernel.org, leyfoon.tan@starfivetech.com, linmiaohe@huawei.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mason.huo@starfivetech.com, mhocko@kernel.org, mpe@ellerman.id.au, 
	muchun.song@linux.dev, naoya.horiguchi@nec.com, npiggin@gmail.com, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, roman.gushchin@linux.dev, 
	sebastian.reichel@collabora.com, shakeelb@google.com, sj@kernel.org, 
	surenb@google.com, svens@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 49b0638502da097c15d46cd4e871dbaa022caf7c
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Fri Aug 4 15:27:19 2023 +0000

    mm: enable page walking API to lock vmas during the walk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fd2348680000
start commit:   7733171926cc Merge tag 'mailbox-v6.6' of git://git.linaro...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fd2348680000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd2348680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4ecd0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1055c284680000

Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during the walk")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
