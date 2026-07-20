Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124903CC32E
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541766; cv=none; b=ufiE6jrTI4SvgXJdO5oYVZWuHOTghj8FrXQHq3cj3HYOUnHu68UVm0DA3AnP7Q5TxITwgcl5oSGMYycskSEtVzsgUG2HuHhVoj/hPH+pXvipqYCr6MtgF3CfnHTGGaFcvN+7maTPcoR/RfH3GVTNtbtfmVSdRZDLEJzL625xu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541766; c=relaxed/simple;
	bh=kaRgDOaw/fDcoVuH38m0gI79x7UGEmCsvKCjyfgt/Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlRCLUs4/2jhdVJbBszHyZ6dFZ+1o1q5sIoa075qEJmSzh2zy00ju/yjILcxI9oQtgLyZsrn5n8pg7gBQAKei4l7Juv0TNOxW9frGr9Q5d5Mf4yC9J1H9RUlHpRXIH2pAp96/l72nxr8/qyKbw26bB/a2/FL7eJFB3a7Yo5W5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK77B5Vm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK77B5Vm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacb8416a1so63863725ad.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784541764; x=1785146564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dnhYXYT9siWEBxQexSgO6rt/VLpCp+EbrkmrDNNkNo4=;
        b=fK77B5Vm7n8zycq2DI5X1Vi+xQe8dUKoMU6Jb5/713+Om/WG+2SbOuGzmsQ38sek2L
         BVSinY1OGqDihuNIF3nAvEjWBO17JmjArJVyhRkD8pEb1L4YFfIhs9TDpPx4K2ltyFnL
         ATtK24cXLskMFfgkTxbDf2XMA5PenJuMaKa3gtX0Nj7Jzl3ZHcSzYF7EwaPRgRqrUFTY
         I895BByvlQekGdYpldAAmA/ESDSzWm+RrnEM4So/yfEJhsc+rg0sWhKL3IComVeHe/FV
         h2WFGICcRpFb35wYjOr2Ay9PbE4epSefCwIjtukVVqHkEYwyPoHI+/zhKfX6irIcutYc
         30mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541764; x=1785146564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dnhYXYT9siWEBxQexSgO6rt/VLpCp+EbrkmrDNNkNo4=;
        b=Y4vJa0OwqSZW4eMgtZk0r4I38iGsQMiEkRWn4KKkUFUSX/I3Pl9cEgOINCCSmomE60
         OQhXKsBBG/8AZgV7N5urb70OPAolJIVMNDHLOVKpFjM/dXRXTmfWvzsgg72r5fg74ftT
         R3S3rqBvGtFMFTc0scLJ57U3QjkFueav9bW1XZwNiCe+YmE7HXCMC/KaUirDOe0QWCkq
         uWgB6XRf7Fbi3dpCSzggA7JLDv7Ra5mS3GyPPmG3qAl2BDAjDD3ApDlZfQUQJSBAIkrO
         xyPgNrlbxQb9MXW13HtK64wE9CjH0Fr8Kh3U5ncsy6sQhCTgBGzoPSjtcc3XsxmbWOcM
         l4hw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6gsluuBttiCjYGU6+Jzpc4czFghxVNnHb0fslDj5jUcSwxOTr7R1O3d5wASeBWuxj/pTI7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3rPLHUswrHgcOtlCLaBTaHdlLTNhAksaDiAeY4juCGoqMzDg8
	NHzKzoe6pb2meG1s4kvFiNcIAEGrIcVdl9lKl2IZffVNaBCesgtldEIB
X-Gm-Gg: AfdE7ckjoHKEdITr8CTybqHRtxT+KYZ+0JHbIsrvkD4gS/sj86AaJIO5iG9GlGQB8Ol
	0wm23xUxUatpqiXphQzn10w0fZYqH5qx8o9TUvlyVvuZl4QqarTIHyyPac98u2TYsAV2gIH/qhT
	93pkFii6C9m2ZjOdXBjrB/KTLFlp8vDtQfSGESfCdsrTyn1IHDKi+cuzN/GPwZEQuKNeNPxZRws
	nZbB9/UhyYP627NL0IDyVw//w4v1fDTj7IQydnLlqrs+K60/wVynvNTrXMh/uAnr3YZWBrOh6Aq
	8ABibwGlOo3C0yvzN066cH/MyuYSDSYqZ8lyzKkFr6zmJhVmLCo8V3h8BSzyM9TWv6siuJtA4zX
	pj4GbLEXK1BkTH2egADJJYZV7J6mtrnk89otbOFxM3RrnctGCNnAChb1JbOXFMKm71aRC/4bZGt
	DXu5Iw2h0MKXCrd8YXMv3vHARH8Ch3WwAz9HD8EQ==
X-Received: by 2002:a17:903:37c5:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2cf34836750mr147318935ad.4.1784541764141;
        Mon, 20 Jul 2026 03:02:44 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471f42csm53933185ad.61.2026.07.20.03.02.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 03:02:43 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: Lian Wang <lianux.mm@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: Re: [RFC PATCH v3 1/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 18:02:32 +0800
Message-ID: <20260720100232.32500-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e01fa50e-b9a7-4c0b-ba70-6088b8d6ddfd@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 12:47:23 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 7/20/2026 6:03 AM, Lian Wang wrote:
> > Add a new DAMOS action, DAMOS_SPLIT, that splits large folios in the
> > target region down to a smaller order.  A new per-scheme field and sysfs
> > file, target_order, selects the split target: 0 for order-0 base pages,
> > or 2..HPAGE_PMD_ORDER-1 for a smaller mTHP order (order-1 is rejected at
> > store time since anonymous THPs cannot be split to order-1).
> > 
> > Unlike DAMOS_COLLAPSE which builds large folios, splitting only dismantles
> > them; it allocates nothing, copies nothing, and no THP admission policy
> > applies.  khugepaged deliberately refuses to collapse a folio to a
> > smaller order, leaving the shrink direction to callers like this one.
> > 
> > This patch adds the DAMOS_SPLIT action, the ``order`` field (placed in
> > the existing union alongside target_nid and migrate_dests), its sysfs
> > interface, and documentation.  The vaddr operations set handler is added
> > in the next patch.
> > 
> > Link: https://lore.kernel.org/20260605161422.213817-9-npache@redhat.com/
> >  ("mm/khugepaged: skip collapsing mTHP to smaller orders")

Hi Asier,

Thanks for the review.  All three points noted -- will address them
in the next revision along with feedback from David and others.

Thanks,
Lian Wang
