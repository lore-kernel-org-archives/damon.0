Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351455;
	b=1ALTOshV32JVnps8Tm1MCk1rY2+RI90VY/DP5N8hR2lx1ObRuHBMkY2f9qudvQJVzMJ/
	 zzHYzXmgR9tkjq9bWJvMuLa07jvr+WeMLDh1SkJ9Ur2KL5HS2YdBTV/CtLonVA2hLNQxu
	 UqqAyp3s5N0rkSJw1auRWvqqdEBf4gCRLH4AqMrRXhGrxsYZ0L/+SOWgD4m2F8g+FZ8bP
	 rUZHo4/9foDNkIqRyl/KTipeNmBdQJzMWU0+vCBI1n/Nq50cCQUikkCng7h9VeLrUS5c5
	 vs8PNDoizlpnCjqH0H85b9giPvoSsNK/40Tcet9lJTSZLrcKeaN0Cipa4QcFYiUc3Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=14LnegLlUwns0/xDAhlDRDvD4G/8p4sFhn7pqvFB7DM=;
	b=yCSdDgZHUITCOLhVEiTiANKj2xba2g5iKmfGz1MsIysCQNbw8UDo8FzemTiMI+X09Ou3
	 H6DRf6kyg0hJMs8MvpNg/cMU3CuYNccbDXH4ALB14bVqIDOZWsBH52V9EfgP7ZBtHwZzM
	 snuIZrm4LpdvH5yBDwhutERchsZqMR9bAigeddpcF7zPpgOfXblsRpRWorEOmCrOqU33D
	 YPW/biun8G0ksOWPFugYmI+YvIu16m51B0+D4VsVLc7hzWxzLZLshqSa0RmykFOCc6QSO
	 eiMkvjCr1FlOmMJMM6/af9FoZ7FrrO6kUjCUA2KFYGCed2BVre2DlnsG1B1WsXzFOsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZofSb1xo;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F3606A330
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 12:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B38F3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZofSb1xo
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-380b40312e2so5637435eec.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 04:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795351454; x=1795956254; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=14LnegLlUwns0/xDAhlDRDvD4G/8p4sFhn7pqvFB7DM=;
        b=ZofSb1xocWlwSsz1oZZDReu0xdIDzDTlgUAf4MsWcZjULi2Bzw4O404Hq5eB5agOlE
         mgWDfTMgKo1HID1Vd+Ff8hOQ4dei4d+04NA89gmsJNy3Tqns6UjO145zrxfPL2hZC1I2
         7LM1irQHQE/o7EQ9DN5Rpvld9EkhREdETKoG2EcCANFJ9+lJnFq8rYlceS24qW/VL6L/
         mtFZ5ChlT1ZrBxkwF1pg5XO0qsEdMslhoEVt9Pb9MfBKJDqzSN6IrccSL0H7y6oC//+a
         ChDBqpz5Whf/LkVKdfPofL6B9IAr5N7Aaoo1jPUkpnZ077LQKaw0vip86qiJLzAsIy6E
         GKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795351454; x=1795956254;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14LnegLlUwns0/xDAhlDRDvD4G/8p4sFhn7pqvFB7DM=;
        b=v6s1TXQaWDq3v5chULFMH5trSUG68Juv1Qt8ko5J3GIIPVvQCfyCDZXdHX+AEQrfaj
         95gE3gz/5ZfhvgBxD+pAOwsGiBmmFshBv85dsC6m7FL30ol/baVH/lbxfHPL9FmM66x1
         fIqakwxax6UzTfaIx9RfrMYTyFOQa/vNZIrkc/2ZnuqEmbdN9TTVmYQ14LJPbnJSsNsx
         EKT1ZN+2B3fDWBWRBYEeCwasG12utr3fgAh0sn/5FwNB3Y0sl8flzyJgDhraDWDperjS
         hhP0yqFMNasCaVkU6GG2MjVjIiXCwX7irTddPYjDk/0+pc7hyKoTzfcGXyCescUHkJB3
         pu+A==
X-Forwarded-Encrypted: i=1; AL+hErGflhhBxhdySgYVT0U/rQDEs+eVVv4EWHyoO+MZZfR7oID/el61KTHWN042jrC7mb/iTAFEZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/b3w+vv3BH0/ie8me+GJI9NZx9uPdG+lIxWVpA8A3UbwwqoGO/
	hTTTtd1EuFwD5QTllh/rYyvdcwMoi29DD3HAt+uHiCCRZ3HgvbFQ5DnK
X-Gm-Gg: AZFdTZfXE6pUnPtGtsax67lXXmtkrv0kkU3VB0tMAUo6uNOKc8oID/R2bBIx6Z4mkn7
	faH9sSsIgexeIyYGOuvMO9n4Ztb4vO3hv/XsmPpIe2Ns0SzIPIf9KM4dQ+pcoLRx6rYP8QwjR1G
	O0/A6yu5+GAgG359srCXKRE0OU8IoVrXFH3Q/00ktzETvjISS8P+M2D/caV8ZI5aoxVw/zif3Iv
	JRob2oYAv7stqMdMmdOUYq8I4mMHW+ZDlTDXZyv/5duqNfy9Wy/EOGtA34yV8FBn+sq2AZ5DE0Z
	kASRXM2qi2gTcoOfO6P2QdPEtOrg6pCSNFR7xBK1//Vr41xxNy1DlcBjkcfQKfv/0aa7MwLCFD+
	tFguS4OIAmGYLZEXaqr5PBQGlFoKn+kkF1TcGE3Jn52z0VqEwM9N9S3D6Doewu/quQOG7+gwP3C
	cs76qwtRHl9q4IqU8byHlz9/QB4giLWcBMHk9/hMD1v01N0tbAKPeXDbEidbXLYvTY2QLXv27ku
	L8MSUkt9IYFWYZQ6V+H2VrQZzR73aK+ENNaaYRGAqYH3ud4cRe4FEe1TyK3XUhWFOFQPFeji5LU
	FoYWIRxwYyEJ0f3UI3CYP2jUK273slxHfLbIW0ELyzU41mqinLE7Jk1eEpDloyhUpAHd
X-Received: by 2002:a05:693c:880b:20b0:386:b025:1e1e with SMTP id 5a478bee46e88-386b02522d2mr110063eec.16.1795351453747;
        Sun, 22 Nov 2026 04:44:13 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm33447310eec.5.2026.11.22.04.43.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 04:44:13 -0800 (PST)
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
Subject: Re: [PATCH v5 02/17] mm/memcontrol: allow update of LRU statistic without holding LRU lock
Date: Sun, 22 Nov 2026 20:43:36 +0800
Message-ID: <20261122124345.66978-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
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

On Thu, 19 Nov 2026 05:03:34 +0800 Kairui Song <kasong@tencent.com> wrote:
> From: Kairui Song <kasong@tencent.com>
>
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding a
> lock. It may cause temporary counter underflow, which should be fine as
> the counter is eventually consistent and only serves as an estimate.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM,

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

> ---
>  include/linux/mm_inline.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
