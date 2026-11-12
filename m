Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461789;
	b=PCCmIgxha4R9gpRX/0ubvM/8+BsvEmN6Tw+wEhBuPgy/2LuyeAdONrCv6LDTkRq4ypKC
	 KxtQAyKEN7SNl0oXIZHG9VlH8unG4+M038NFvtUvAPsbNhLh3EM28lsVzkOdZiliqgs9p
	 OyijWQVK0K7MxtuAp+vDk4Z+t0WpJaFX+RKUVpzntsrYuE7Rk2mWsdrw18iZV+Ak3Tdbx
	 Urz2xgXlsErx+3KVpEU73PoetmNOXTjP6pZsPL61j4B97it8AUHCSipHsSAvHU5nIMKIc
	 Q1D5nI1H8QTslVPoZP/6a0NlVFgyp2umUmPC3LL9C4D4B50BNpmWAC6vN6IlhQVQv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	b=ojPv6hi6cMQCCxx50P73DJYIYIs9HY3HTCrh3h36L6eMoe/KVxxhWBBFv3I6UgXKXvvp
	 WoIRm4ox4ZLXq4znCm4TPwG0zInVQSW0T6bKGoRhJTwt84tQQsma/Frf0CgRsL4eE4X2Y
	 9VbtNrFrLNkFcwRtSDcfVHV1XN9ScqhE+RFQKqQfMjkwZRKfKua+FGuDJZZFtbW1kJqVY
	 VuTS76YHllxD6lp59UVnxF+YqfSFV7JrxR59n4wcN8ZUCkmXV/Rz8Px+7K16az5EfpyuU
	 3Bun/hmC2i9HFZp5iSu9jPuNDooCPPuw2DE6TLCcGofgYiiRTrruu4ojlqIXpRVeZuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LL67M6Nc;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C286606A324
	for <damon@lists.linux.dev>; Thu, 12 Nov 2026 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C286606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LL67M6Nc
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e55db58cfso352338985a.1
        for <damon@lists.linux.dev>; Wed, 11 Nov 2026 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=LL67M6Nc/IxVGbNe48ElrrUygZKdp7qdfg2CobwrmdDJkE5lLm/3bDU/UcwlEIQcW0
         cXXzxnlJbTN1cPqL0DmSxw449iTI1FfZpr95IqOtaCcB5XXmh7b1aq/NrOkyqQ3GkOY9
         Y6TMkNrYo06sQDcUyCCbsLs7z78OiWMlxtgyul6qRzUvAnt0D3R7iDgukTUSNu4wtF3n
         cRImh/MLomhy3cgcMKlgnZN55MT+2y9hzFOC0JI2pTkn8nPi0MsodNfY+1w57InRST9F
         3vpEb9UrBp7OI2bvweFCcIATxZrx+ydul5S3VrhwyZ6RXSbpr9Km+VTPDaXwIdt4GYM4
         yoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=CCxl0azCXzMdglABMbtGb0H98r7iiQfECiL260DwXGQfH5isoYZdihniU2VrHRysCR
         huw5sTjp/X5HeG5QZGeSeIto/avDnhtpRnVW0VnjowfpY+sYmUWMX0I8wcP7/IzFHyff
         qPpg2WsTSQNYFXCL4dRt+TwQafFFvOqFip3roBpbhEdTkyns7TN/LXOBcl4Nz1iae+oX
         snfszSGJ2MkRRQ4gRqZ9ytDdF7Y5+bOBPFspkAr583q7W2S/mttoQ7TysURbziuyITJE
         qLcNy0vLguVdkP1INJcJQEPP9mGzcM1k7znbCKZ9dv4um6BsGa5nu4XruYlKkeuliLCN
         OuKw==
X-Forwarded-Encrypted: i=1; AL+hErGhu32Vlp4f/whE8WlX8EqzFPKZF0B6jaQe5rvrWZdpoDF3un+ithBn2r7Z/bHMgvjswDN98w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1vFFmumsd8bnVsipljlmR//5ej6U/4aaitoOVZuPriR7lbK+b
	aEaNQpETTe2S/kZsA+Z31mnPfO3TbzjNs8XNI7QohTYPKDw4QEqYs75PV1TilzeaT1s=
X-Gm-Gg: AYBFou1b3FAft9EEQWn3Qrfekq9Jrn4+dNLFd9fx+9AiMgt3geYtExPd2Sj75qBn3Hu
	g2g+2urfTRwt8GokBOkqRqVi11j5VJ7dLyIIL0wNDfDIjgv5/tHfh9Juddu0TzcOv2hjbIxVw7p
	AlLcN0bJx/UM8uBCwCgc0BUURytVjMpxpJejS+/CYn8n/mbsD9abArp8BeytwmJ/DqddBeB8TGF
	sZ/l15ZQ/IfEWY2GJWxWQT3n/KxhMxBmuOBRtzNJEqoP+b1H/HWJ57AY+xPTcE65R6DC13b3DBm
	9ztQIpHt41NBbmutGVB3PIAeWAkZybt1JwPabHRUPWCAQH8jvDZwN6v98wEFym9QsNx5Uf/HKo3
	VLYYvt6V66Q/ZN/AtI/LYK+ww+LDGyzjSuP1pNqsGhRVIv4fHrEZcDx5eMPOk7XLLrwxP81ZJM6
	c6NVUoUFG49SZPZ4sCHg2aGWck/WAlq+Z+MThQAPn7auzISayAkrWSM+a+1fTELT+iQqNC51Z5E
	l2Z7SEFxqZMxVhlKfLGlh1ld0CFdoR8rjIGmxHeURKRF6JgvshdnQNCgowRs6Ezjlngj8C4q/UL
	oPiP5+NnXGHbJgTG4uhjRaUCqrcI6PCmgyyNuUzlxEP02qnYpvnU//A3pT9CJrxvt0c1vSa9y1Y
	lRNaX6Yc=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

