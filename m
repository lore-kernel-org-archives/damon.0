Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716871;
	b=JzKh9EZDbMCvPAE+vvgRurTE2lDQAfUiW4YuA9APfHEJZwRaKzVNscq3iGijDEPYYWWC
	 bkg2m4Zg5b6Zzr03R9oLPV7FZqRZsSI7kpgYnwg7s8v15t5SixSVdzWq5BE04IEBvUcau
	 bAjCDnW92cUhOAQo1/G9wSnMaaJdth4ZT+XQAE6hciVmXat6NIkaLTaiizCICIcPIstKI
	 rDcBDeS8PF7wFEO56R/Kid0xIdbqLLU+oVWg8XTxpfAt8SE9L/mnp8iXYMBZa6nJNIVUw
	 4sNi1qm9qjY4Mu4NygE8sSLzKo0egQmLFdp76ZuNFMh4sctXWfYml6FeMAo0J74zPiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
	b=CT6TUw9SHhG8SxFD8DpxeAjce7oHEDKpULIbu/8USJTLskBKBJkCRwlIJLXzoijvn7Zl
	 g/0AOwjezXCtBBNI4fziQW3pGMLzKv3J1gNVKF79s+pRyGO1UcZNXN2GPTxZ1MEHiJLhe
	 lrPIEq9o+PGqxPLM9ei1lGKM7tyJA+hCQVjJ0i3gHq0VeBUawfLdcxhCb7+KjMZn5NP8E
	 d81vQRBYqAwhBgl3bWi2w7AublC4+lQeMBNtxel2vPZt6uw2usswmX50gKDeNF1oG+uvJ
	 NlBwvHQl5zesU2SVNYFdmQLHuBChV8Jl3vOiyezgBOuDdFl1OpV4keMC6qiHxw/Xm1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c3VKhBqL;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF96606A32D
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 04:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF96606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c3VKhBqL
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so3364574c88.0
        for <damon@lists.linux.dev>; Sat, 14 Nov 2026 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716870; x=1795321670; darn=lists.linux.dev;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=c3VKhBqLnxwMQkjmUIubVeYN0E61+/0xCMlLVKT+ZCgmSQ8QpxooHnYEfm1kSfG6tI
         nH+bEU4OGQ4/6+Ho01XrZaMNWlyBAJ71jBafsogd7YefH8CbRCginABO9+3w/ff/S8ep
         HKSXLaEsuc8bE8oVb5RwfG6Y3HhxYsDf51u3Qtl9Snx/OogZpS9LcK2Ht4xnAHozO1B2
         9ieZUaHnDzz0oGooFyVs6RCagnZAKbdAWPo85LnZ89KOdTj0TWio1XNhEhM7+m8NdS7F
         gI+wI+EOcecWD37SB7biwf2aNUbk5bSYTZXNFAD7m3RSKWyZZfelv+/MX1s62noO7Xgv
         Kpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716870; x=1795321670;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=aB6gHqVdljj0+ud8sh/NRvvHOCwdhsUuGpZSRDYrGHbMSLQLGRGAZruYyCq+Ug/iAh
         Q6c1K3USNyQ9lo/FBskJcAbOGWLsnNJpfQ0kODizDr60v9iy24+6wNQo2/hbu3NCVfAe
         hQ/jtHdzuY08xbfDgfP51Bkv37TUCVJh/12Vg7AuiNMib331yAMFJQM+mBtT1WTfU9zL
         51Yf3XxYn4u09mSyVinUUKVsgVdxeo8vN1oLcqV1jEcEqNUdVGd1H1M3V9Ul5GS/Nc26
         CQFXQv08I2/hPO65NqQYNLfgwIq4SQ2/eqbu+CwvVIG8ptNctjKaaXjVNn4/MP0pzx8u
         6eJg==
X-Forwarded-Encrypted: i=1; AL+hErFB6eTGKd4AFq9mtQBRyZlPwHYpXOwd1+ZOp5sVGpoMAfBcT2fS50puV28TuEBIa1BAu0QtdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8YvsAxGHAZCdvPhsEc4BZayEYafluwDaawN+7BLq4LCvalD3hO
	m2p7CB0Sn3EgxgZqZHqDwu8o4r2h+vw+kbDX5dygk+B8byT9UytX3NNE
X-Gm-Gg: AYBFou1rY2vT1uSlf3D5vznjr1g6h0kUIefGCVY7mfNSrLEftPSvBxpwWdCIHfpdS07
	7Ip/NPo7eBu9R1aXIgDjwMexR6sCie/Dux0xRAxpXFoQFub6eX0K+NYj8+5R2CUu4A02AwVqHz5
	vEEMphpAbpNEDokK9oCVqkZLGgsTswuu8gRYFEj9q6jyTZjiiRLG17F59gES93fD+tSD0nV187N
	Yv6AYzWjvVfF+q66G07hYd6iQx/yH2+y7e0gwJ+aluvfIvnFOi4+hFMOuYKpP0BWgHQqlLvoiXl
	KdOEZJ4U2XAQhl1sE5ZKhLGMTX/g7IpMhFBS0LJwmzjIr8GLSDAmOmOGbWqPSPsjU/Z9TozyGpN
	EXvXprlFB8rCTcat7p9lOFnIMyXES9DMJNwdLW3SKlPUCvpGvFughDzR0480z/LhqFh2cWVdbfS
	cfiCFIqJfa8fw/tHZWc4WyhjfS0wLYiirRhNI9QZ+4o9FUf16OZE2TaK0ZDU+/bOjo5otwVv84Q
	9rZjqOeA1V6VvhmJ92dDEqvO6Hu3YF98DAWeCjqZeVa7tM75FmSyGDEwXDwtjWPhitCQBJzHScq
	kGtNdffW15D8Tc1PZrzHZPcL8VI=
X-Received: by 2002:a05:7300:ff46:b0:37b:c89d:1d56 with SMTP id 5a478bee46e88-37bc89d354bmr1627673eec.12.1794716870280;
        Sat, 14 Nov 2026 20:27:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm20640706eec.6.2026.11.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:27:49 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying
 Huang <ying.huang@linux.alibaba.com>, Alistair Popple
 <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro
 Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park
 <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes
 <rientjes@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
In-Reply-To: <au-DXpEi4wHwsz0r@gremlin>
Date: Sun, 15 Nov 2026 09:50:28 +0530
Message-ID: <7bie914j.ritesh.list@gmail.com>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org> <au3r0-geuwtRYPiC@gremlin> <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org> <au-DXpEi4wHwsz0r@gremlin>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Lorenzo Stoakes (ARM)" <ljs@kernel.org> writes:


>> > It's not really all over the place, it's converting vm_flags_t to
>> > vma_flags_t across madvise.c, which involves changing a few function
>> > signatures, whose callers must be updated.
>>
>> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(
>
> Yeah it's quite worrying that... :)
>

Thanks David & Lorenzo, for pointing this out. I have changed this to
use ksm_disable() instead [1], which then also removes vm_flags_t usage
from there.

Please take a look at it whenever you can. Since it also removes the
EXPORT of ksm_madvise(), I think we will anyways need an Acked-by there.
(note that: looking at those changes, it seems like it should go via
powerpc tree)

[1]: https://lore.kernel.org/linuxppc-dev/0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com/

-ritesh
