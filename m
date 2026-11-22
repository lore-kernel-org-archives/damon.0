Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353297;
	b=1PsVu1KfI8GynSfsUJs+Jf9QCWjnBB0jKNbhz1VqF1VvINSd2Us4P/vhCf5xml8iJj5+
	 s7bPffxgnU4pWdpSA4qxdhTrpcEjdrq6P7Xpvf1jondRzts0XPr22O3RcMRpZ6FHvFY/o
	 BkKnbeFSD0Dj69li8m5/Of/JRI90Daz4kP/ObomO9yH1dm2HoUsiM+LeJOqydrds3FYUy
	 0qLFgg/isJ8C/bC56lB8yl85H2vWmlP0rQkfhrVL8pPLfc+fpmOHFGKT04OrSVET2lSaj
	 eqNxyFl3ndDDm7RjRhP1LgQ577EUR7cxmD9I8UOVfc89FlL5UJ88REHv2UQMAPp8IGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=8hD87ixJaXl21lUSGIciEwnoJt3nWlHx7X6q/vGOsOE=;
	b=ZJ9GkU2GoanGvKOdD6U6pgxRCZovepJWKVqlhXglyMB4+9c5oOYfCnxLlX1/hC+jhML1
	 mNS34QXCjvGmNBQIfwKvx6x9PSncgNwiEes98RQZoqXiGl5Osh88Y4jLl4SRsv/fT0C+u
	 0xPwNJqdwVypJ1qbqH9QUvv8SElAfSZC8nnp2fmswdl9GQm3wphgyh/azv81DFDNqShaw
	 exuuKUklWhURhg7etLmfaJC9zLljOXk9HC0Jc2ePSDMaUkW1KwQJGqN8huqYM2ErSYiAP
	 DjZSp6s9z5fIgobJCnI586ubZw1DsVwrV+IOotqcwsp3jwcVea0X0s6WItxEHeOgKVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQH2+ojR;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33674606A32A
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 13:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33674606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQH2+ojR
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3ada81853so2678156c88.0
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795353295; x=1795958095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8hD87ixJaXl21lUSGIciEwnoJt3nWlHx7X6q/vGOsOE=;
        b=cQH2+ojRjhcrrqkm8cw3soJNf/ojoj4qLDD3UHFb6HRX2GgbzIvPEjKimH9A+bGYEQ
         mSJ4zFTNFCG7wD9auyxYOZwvorVow3ZkF+GinRXEeaXHkHc26clngzUkHcvB/qtAP+7C
         GUe0MCnuObb9890zyXwkyGMh8pMIsrQ0SYCokWloKIJsXl5qJ4X7a6i7VK9VgHCfQNV6
         AIoAoV0tzI4N7gDD9b1T0uIqL01C9HIw0yGRDCQDup6F9a2GGDOR1onKSAI8OwnIOjfm
         yzy1M5HY7ebCBbsnI0h+m/aXgyfAqETAGeAkWdw9/vrWW0SjZfnoH5ICzyTzBc7Cal1/
         aDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795353295; x=1795958095;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hD87ixJaXl21lUSGIciEwnoJt3nWlHx7X6q/vGOsOE=;
        b=lLEN0rUmr0q3C8oVanDky/kmtAxK51S1KVy00Wey35qEuzzaAxko8M1BFBd02YE6Lf
         bA8txAet7hkeF3f4/SJmDZhCK4T1oK2xO1EOGs+Jtn1IDECkSiKAYh4MtARF5wkn1IiO
         1CSjvndi1ekmLUi3k7h8m3O6dbNnKl2qhUsX9E/TSIWCV4Hex1aM0fRVhSoZWJzIT55G
         jE6tud+o6s3xyMk4yWKeV8+6y1WVFGUYDqHIc3GL/TStIxqk26HFxzrfP9NGsNpvrhfM
         DKdxt1mcumSbp2tp/kjhNziKsKcWXnclEH2xAdGGWzP2+k/6Vh0lZ3IRGXh30eN9GLcV
         9hig==
X-Forwarded-Encrypted: i=1; AL+hErEcJobFh4XAPaltedy+Jz8XhL0amN9P0ly+/CCrqZJZ69SfEJU5uzxY7EB8iVoCMn4Kd3ezLQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+VA8SbfMtFOa1oyJmrYKLzKDyxIWQRYj2ZRq25pW1C5xB2Z3+K
	oGU53AxyEf7H6eYA1SV1dYfiZP4IZ7cXHC6X1tdpcSpWWmSyUROrCdG5
X-Gm-Gg: AZFdTZe3y4MVNRVKMQmxVIFu66wPFKAB5mJUwQcMCLfMwv/mKeVpmd0wfRKcIwJ4Me7
	XsWPXPH0IZr44jIFbxFQRfCveczl7YejKMJkwT2mLB8rQIBerauBHLi+PUuFxdtvvw3jcBDBk+r
	j/VU1nRhzX5iDR3Ay6/KdudXm97L09BIRj5uTSp5UhvXyXWOGuirs05L/6Z/JjzaLsrcgy4PiHO
	v352obtAGpGRjdkZF2YVJ5PiLLUVpQCuqk8cdEkP6ZvTP4EGiIOXJq0h4q4sSIDjdNb8w5FubP5
	RWN6dh15xnacfq99vgDpxmI3NIl3aoU2DA6O5gXUJL+501iFFk5GzW9WrH2FjiNF0rjIbsCKybQ
	7B8+qmf3KUHHLqC/9BQTH/PwlxuVJujIaO23LrbkrHtPJIwFAyTnMARZTirJTAL06dSUPvSQuN5
	jmzVyIcwjPOHywTSBCVnewEFnllaq9rCWPHjjZRbdWJHRTnqvAQ+3En/yqGLO2h4fExAWipHN3C
	VTJ/u1xa5mg2neyZN0tSZoWCI8MNTp1mYWe8qv+4aOczC8HDoI7BN+UN63dQLIgg9uKrvmal4dt
	eRyWzenkrOiJfKRMR3kgV4jNfNFLRkfOSCOzDqjbGviP6pbO7VlX3KrI3CeAg6qJ+J5w
X-Received: by 2002:a05:701b:2215:b0:1b2:42db:8a54 with SMTP id a92af1059eb24-1b5568b3154mr8671867c88.23.1795353295194;
        Sun, 22 Nov 2026 05:14:55 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm20797941c88.8.2026.11.22.05.14.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:14:54 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Nico Pache <nico.pache@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregory Price <gourry@gourry.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	SJ Park <sj@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	Zicheng Wang <wangzicheng@honor.com>,
	Chen Ridong <chenridong@xiaomi.com>,
	Tal Zussman <tz2294@columbia.edu>,
	Kairui Song <ryncsn@gmail.com>,
	Xiang Liu <liuxiang.277@bytedance.com>,
	Ehab Ababneh <ehab.ababneh@intel.com>,
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Hui Zhu <hui.zhu@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 03/17] mm/mglru: make generation page counters atomic
Date: Sun, 22 Nov 2026 21:14:27 +0800
Message-ID: <20261122131433.72335-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 05:03:35 +0800 Kairui Song <kasong@tencent.com> wrote:
> From: Kairui Song <kasong@tencent.com>
>
> No feature change, convert them to atomic so we can update them without
> holding the LRU lock. A temporary underflow is fine: readers clamp a
> negative value to zero, and the counters only need to be eventually
> consistent.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM,

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

> ---
>  include/linux/mm_inline.h |  6 ++----
>  include/linux/mmzone.h    |  2 +-
>  mm/vmscan.c               | 26 +++++++++++++-------------
>  mm/vmscan.h               |  2 +-
>  4 files changed, 17 insertions(+), 19 deletions(-)
