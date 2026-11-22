Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391218;
	b=IgkAtyV8sMkfVOQS7ZUWAYjpuDxwmY418LtD9SDMKlqgO7DsTlccV4zoZbGTTUACsS/t
	 YcrzWI0nSSO6PFn51TYz+Bu4c7oJw/Jaa1tvFGqCRbifrHsY5ydujTskblcFCmVKt4zrd
	 TO8D6hC35bu+KYPZpAFSZU8dj0u9UMy9pPvgAuWjl0h7pqzFtst5NiXNax0CBSPQ1yd9K
	 PlIzddpGOBRmqaHdwsaOV8vwKyIaAL4+jU0EbLszzmpxpvLArk74bfnPy0cD0+kjcNx2v
	 LS+68hy8Kvt1XFvB85N1Sh7ey0H47sbrkjBp1kxQpYqYe5sp4AWFNCxD/4Blp5wo+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5SMUhQZLvGIWMEWzTIwqLJCO1x/4SePRxnBTKofe0h8=;
	b=EVJ4ROL3yj1QGIO14KbnNKHFGRniD5m9WAweTqSHraiLZ0M5gt/5sgs+7q4wVL5bDfSw
	 q0XjuqrJklzUEBmKVRidDvszu1vGuLRmK6/C6FLyu4Q5KPBxe+ra3hYTXHTVLqKdXYAsa
	 9vZmLOeWNhqSitVwN+1gb9pXaBAETtY4USzLGsaH/145brfTa+h97OhPZTNWR4YgAKIld
	 xAdxcc4LlR9iazUaa/LuVIDwcQT2X5is27/fv5Igm04XMZm774Q2PlC62qtBng1cOsTmV
	 3Hm5lZHDd4kLAoa3mJVSaA6py1ZpXfcLxUCCz9JfsgGsNT94XfD+m/u/q0RGD9zSikA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ycxOkfx7;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE9606A31D
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 23:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53CE9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ycxOkfx7
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso1070016a91.0
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795391218; x=1795996018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SMUhQZLvGIWMEWzTIwqLJCO1x/4SePRxnBTKofe0h8=;
        b=ycxOkfx7AORf/kc0LGHI+M1c/kWeiS0WCLwU4OVqX8yEZnHk2HX0bQvRCBSTuoihWs
         jrMOz+FHMAvSh1+OHmMmxPUxq1E4Y6UQvcFVEjUdcwNF+25qc7hQaZl8BQ3sV8HVYNXW
         0V2peyIWMZLuY0tySUUkbxVaAyEZKvDIAJbSGwBGhw0aLNonyVUcTSNyVbHzxsMQGrZK
         9BxVGXMRmqjrEe0yybHMPsXXNmnE4n5hxJVUW+0h6di5/vkET0znqe+5y1bz4anM5LTW
         Yk/QoxQS7X954kDDOs1UH39cu8pKGeqZRKsg9oBhD22xUNEACGMFPl2h5F34P70+QIvY
         t84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795391218; x=1795996018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SMUhQZLvGIWMEWzTIwqLJCO1x/4SePRxnBTKofe0h8=;
        b=0jmzAd3BKNYkEcdAhT6w6DUJf1+Q+KNMHSY4B6Sz8EGh1JebAB2RZDNdfeULQoXgT/
         Cxr5XfIPparslfufy68htqLpcwbvmfQRVjKBOrHszhxFrE8vaJ9D5ucpdXKW9NSNK6+G
         agUStmXDqQFPRzbU4cOukxwK3k4hWmcJSHCEA8vg8f8O5GM9NhnUj/TcMEIbmuZq4SE4
         PZJOamg3TQmf6oG8Hs4WMr8YO7xfJOVg4FtcgPv4huG3K/BQJhHOXXM36YzqYGyQZfK5
         oAcDZ1UT1795NCmUokpiMT6/yNvphRLgcGe1BYh87HXhl5BwMMIQN4No9AKiM/4oK3pX
         qfZg==
X-Forwarded-Encrypted: i=1; AL+hErGyHEPCzEN2wDoPPeUNySNoeoD+/QJQ9IMyXBmyxgv/xo9XFURfvnW6RTvTzWzvR/kmVLff/A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/IF7XpZOruX2xZqfqcKad9lTOZuyr5HrVyYUMgHRJWcWLxI4Zm
	6+uZtyq/J5rSrcPDMEZ0dTETMs4M2oBj4fZp/pK8XRA/mJqXUUUFnJ7J
X-Gm-Gg: AZFdTZfkGnX6bf6vrVImSAmcXN8RnHNDeK7n/2WrRmSKAHCbdx5oaH/lkGdPFCFgd1s
	v8qCGdIe9sLPifQMNZ6SvJGKpQtyu98ga23/pyKqywLd+26shM2kwLICRd3muu20DRkMiDbffjs
	ssD2jeB20Eo8WmOY9TaQj6/prSfNmguBfjRPcWbQqajC1P/M8Anm5VrsAuJ1Ds9f/CgvtpeVIFQ
	AsrXZuL9yvqQQA/CI24tzyRgNt2GQ8VpC89LH8MWue69/0EGHNAoX/dgqmHn8b52OOY21jWupll
	84XBsnhxqfZGUXfQuZCLXGw8ABJ2qOsA4hF0fclpUHHq2UHjQCXkwsvH1D5xW3zG7JGqV1+tBue
	+imvlvf0+IUblvD7Gadqd/SOPE8ZAaTyd1mCSwV9hQ82Djv8BnbCpwKuNOff2UCPNATriCZmjKc
	Vdog21UVnRWtl8v5q8ffklWwa+r3HO55NpeWJ5xHDJokydnSDgSWM8/IWcJQgTXLh/69KMGB40V
	76eI/qQ0OSCtbgXnSCt7ZtAz1onGeIDZnOp0EryCjIsu9c4Yk0WqdZn+ZC42MDLzRf8rEC/MAKB
	bfsbV0QVZ3M6tliXbcf7E4dkk5l1Rcou3ShGG3tSmiWsDbwyONCwOFkqBFe9I+SgteLSCxh9oTC
	ObmxUbZ3O5uJk7K15KuWpuvdoEhRBOwdTTIeKGsfodhE84jaK5xpcxEU1exFisZWu0KDKUulpiw
	cR
X-Received: by 2002:a17:90b:4b05:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3b41c911c9emr8676680a91.26.1795391217624;
        Sun, 22 Nov 2026 15:46:57 -0800 (PST)
Received: from localhost.localdomain (180.36.101.34.bc.googleusercontent.com. [34.101.36.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad47091sm15052556a91.10.2026.11.22.15.46.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 15:46:57 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sun, 22 Nov 2026 15:46:32 -0800
Message-Id: <20261122234633.89529-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261122012222.148520-1-sj@kernel.org>
References: <20261122012222.148520-1-sj@kernel.org>
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

On Sat, 21 Nov 2026 17:22:22 -0800 SJ Park <sj@kernel.org> wrote:

[...]
> > Do not restore
> > it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
> > the scheme would stay off.
>
> Is this really necessary?  If not, I'd prefer restoring it always for
> simplicity.

Thanks for the quick review.

I think it is needed.  With DAMOS_WMARK_NONE, damos_wmark_wait_us()
returns 0 before it touches 'activated'.  So if the scheme is
deactivated when the metric is changed to none, nothing activates it
again.

I tried restoring it always.  I deactivated a scheme by the watermarks
(free memory rate above high), then set the metric to none and
committed.  After that update_schemes_tried_regions never returned on
my test kernel (it does not have the damos_walk() fix yet).  With the
check, the scheme is applied again after the commit.

Thanks,
Yifan
