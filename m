Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347541;
	b=ovGTcdzwCzJgmhOiZzlVvIO82a/CK/KoiI8rItf8cHgkbpL56XY9zvNIbVmzGsxT+e+g
	 QFXq4aQV5AARfWSplViw4pJKfb/hQafgnI8rVAPdjCFOx0aRiEyZ5R21QO+tyceyCAV8U
	 zbBk/g8wZ6TlCvZruiY5XuB5i+SYVinwLdTXLDSnRR6U6dfUBjrONYSBoXA4QYSEmM8BJ
	 MZe0w2CRsdd+CU+VInJ6XUqFidbAks0bwDf9QthQa5//tooCReWhzfoHgERyRh5/YHAM3
	 onrTiZII6ZOC5h1FO9UIi8GeJcMDwHAtEzokcgTo140cHh/xmhvnhuBZJL2Vmx4wP7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9SL2nw3BljIJfL2BNxy4TtTwunpxe4OhPHoB+8Eji+8=;
	b=NwlGzTC0KEn7XBZDqLyfJ8woOmhOjG6TAi0bL1R14UMh1fa/mnD6UzI9AFGHaibcpbo1
	 8U8GFYh6OGTOAAqGTMJbAu3pAsm38WNP/+1aeZT+5BumNzceTQOdSAO0/4r+NfamYwePc
	 KW7yhxwchsvfYE3ABxmklHNI1C1ErFrzfxHZxLhe7r+UO8mhrHM6e5/36AzSOcwcyw3MP
	 UCsAfrTFHSi6ZC6ND9Q++MG0yi9r7KR3SE50UTAAXIGETyB6etALuLvGfpvtoZE+TT2aw
	 VwIhSyQBOj0Ux6nEB+74E0Qk40nLheBIrQwETq5f+C2wb32GroZOV6eRbt9I+n9JXnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmCMeZEm;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC64606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 11:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC64606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmCMeZEm
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so7176223eec.0
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795347540; x=1795952340; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9SL2nw3BljIJfL2BNxy4TtTwunpxe4OhPHoB+8Eji+8=;
        b=FmCMeZEmV+UFC8VyL4Vb8lhAXDKlZGwozgCF8CKGWTT2hHBgj6pACEWbM9OLa9jdml
         EfXIh/jvxX/xab53P+Yy7l+p4dgofrKntIRRTYiZi7VFg4/htKDft54+xsQBVIQOMlSU
         uUj+vqGRLJPoVGZpxhG67x1wd+8ZtcTduMXeBeUUrvoKR14kHcIn65+KrDhnhWOJ7f/j
         keVybt8UQZhPTZ0DFO91ezcMQfKCwwnCY6HCRyBJLErkTvnzv0naaoG9RzjuXCkX8kfj
         xHgQxLNYyMaTpi8cOakl2wAbyP8QOkzVVWSKcy8+F5itnLKzXl7rLNUH0YGiAVOsDBac
         /AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795347540; x=1795952340;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9SL2nw3BljIJfL2BNxy4TtTwunpxe4OhPHoB+8Eji+8=;
        b=Oz3CWQSCvF/Mze6zCagMzk6q31vMruvILCaZBsz6DTTf8k5dizXY1uFEHLecpg4eMQ
         RhkhRdIM0wfmqCEdenNk5d6gyM/DA1jkna8NOiPlqaXTrHFclufmHpgpLJYSx9QWfwmL
         8wwO5M5EKzfkusNBo1s6IHgOnGsh8In892ylJzOdp0Rbn9VkdBMQEn9othyUb1scLwdX
         bary2T1R5Lxwoo68mWbdGZxILp6DUcCEJ27+9Dbq9tvUN96q9qBKCcY3OnM+S2H8aqW2
         wzQjImFkM7ENedGGSXNgx9mKtbN3w1PEqnka6iKQk8iQx+9wRGUhHtzML1asv/rubMtu
         SD/w==
X-Forwarded-Encrypted: i=1; AL+hErE2s3+JtLxpHSdDKe+ttyC61u2dXmdEXaXzl1fdVyDOpGdpDa3YztQEabuPdoDiEgtmCcxR7w==@lists.linux.dev
X-Gm-Message-State: APuU4Z97GY/Fei1cb/2xBXHUvm5S/1WvMnFqtCw9ym+puRTnRctd4FqM
	IyDMGLPM7COCRDMYluc0N4TbnJOKx31k0Q1h/Sts2LGBU6HsiGOs0MB4
X-Gm-Gg: AZFdTZeANGcofbQL1wGhmrXzaZ3PDtsguT8vplmZT9BT56G6d5PdEjksnnpPY+vrH82
	72U2PJwOWmvzoBnExUZzqjX/0JZOm5f3qPTzMOeBboj2ny/sBs2dKCDwj32Fjb09mx6C+jDfoLb
	PZVXzE0SwPQb7bndKYkg3AWWoFeNThCyYgxX6gDpXdsSFNNJ7gMvDAnvWtKSZ7mKYrw3dSIMKiQ
	IzbOsIv+84w1XHsytJZGWGZevBqxkYN6DjxhnqK60B+MZ7aWfcaxUm3a4P/j48lhVy0BzSiJFel
	cRVl4ocgdTI4gV62RrFJnS979J9Xfp/lEmJT130DgHtWEIwvk3heKLu+GYolraZLISFMJOBMy0u
	bh+ehyUwZoy3B9PJh+STvbfHL4+4No0/xMWhz94tq7rk/Jwc2mbsbYLn5PIbkEmfMkT474RiSvV
	U3j1Zb4pmvABufBtoIGFppv5K5wlygSkHc51b1aV1VxY/aAWJcLnrGLvj6EW0KOjE54ZuJ0eWS1
	wT5FFw+1izcnfA0NpvlFJAZPID8RH/FImkQtU+g206PCBqQwEOncrN4ZDsXDjGiDjNhgBrLGcFj
	tHfOAeNnnFDKeUvEYOwKeWqJKNDE4u5MYOzkvzbmUSQZ2sa7+PzPB+mfKsWY6UHRBmhZ
X-Received: by 2002:a05:7022:f509:b0:1b3:ad88:b9c5 with SMTP id a92af1059eb24-1b5568b7e07mr8368775c88.24.1795347539687;
        Sun, 22 Nov 2026 03:38:59 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm3717851eec.18.2026.11.22.03.38.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 03:38:59 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Kairui Song <kasong@tencent.com>
Cc: wang =?utf-8?q?lian=EF=BC=88ByteDance=EF=BC=89?= <lianux.mm@gmail.com>,
	linux-mm@kvack.org,
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
Subject: Re: [PATCH v5 00/17] mm/mglru: frequency guided promotion (MGLRU-FG) and flag cleanup
Date: Sun, 22 Nov 2026 19:38:17 +0800
Message-ID: <20261122113833.62817-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
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
Content-Transfer-Encoding: 8bit

From: wang lian（ByteDance） <lianux.mm@gmail.com>

Hi Kairui,

On Thu, 19 Nov 2026 05:03:32 +0800 Kairui Song <kasong@tencent.com> wrote:
> - Rebased onto current mm-new.

The v5 build checks on x86_64 passed without issues.
I'll continue to report results from additional tests and workloads.

So feel free to add:

Tested-by: wang lian（ByteDance） <lianux.mm@gmail.com>

Thanks,
Lian
