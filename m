Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931052;
	b=o4Gp+zTok1+CYJ6duLqdOD+vliCbcqKRVvMlcFOXwZH/9wnf3PndRjSVfx/16f5a9daS
	 fv3ZZswoJtzPrl3mkSjD2aLRDHkATIpmFi7DkCOAtHzHJ/e+OChcRBee034j6KzRLql2x
	 tE4zfcNATdY3RLccAK6jQcqBusmOmUvYsedn4DvILIONEwGH9e5v+kIHbnjse2EvrX9VF
	 8YBxzG+bGuWQnJCKuUZbRMGg88k5lZDPBmOoTZ7Ohs4PG8s7D+IVK4gwZXyayAAt2hVOx
	 uzN5XUrurUWWwOomW+Sk+V0QrXr6GEQh6TiRoTjZlFY5VtoVnDkodSg5ZlOPFUPLFBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=3+FyKPryUnxHupmwOSIIYdOL35FcAHgGEhz0DKQNfhY=;
	b=pLKXjIUaziXJLTM+cTHrVNmFxJdbSArlEFGw4/94Kr4eJJyRwgsPQtF+F57Q2QpgGZbL
	 QEYhEV5y67f19HCxXxiH9dssJzZI8n5Db6VhUWNVYB6M1klb2FeSaNoUGDv8GYyYlMML2
	 J3YWcCOqDi8pVb52Jr9wlBvSGAc+ELqjdmFfBNvmQ1chCyt2VqkggvbGRZrEQbHn6eGQw
	 pjBNyJ3D2eHarKfi7jGEdNQepZdHh31EpJpGTW0L85XJduLIWDlfVYjj4QbuRxQYVDMl4
	 chEFaj65ckCwNg/Xs8h3npxNBR7Df3/EaB0UoPQ3lBYW/XMJlLEAwVHmSsSV22pWjvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZjB+ths;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B287606A32F
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 15:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B287606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZjB+ths
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b1478f06e3so1317606a91.0
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931052; x=1795535852; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3+FyKPryUnxHupmwOSIIYdOL35FcAHgGEhz0DKQNfhY=;
        b=nZjB+ths7eznB2UU7XZ4qPBh+nTw7rUi1WODAe7DvyunmNIVB2Hqteb1QhmCqDFjn4
         cw9y95/wkvyFjVm4ImCXn+1XecBZSap+waJMBjp1o9EIRrV/oy/qWmFLjfhlHzwjaOkX
         TrXTiT+yiUBUpkeEwcZy3QjMQjZhg0azn4SYNTHUQqtFtkganKl8W8Mt8xkFIgUQEpvL
         BvECECvPGOemSqAAjbG3O71czIunQ6M1s7syjde+3CYihJvWUGWT5UL4chj3vobkiBj3
         qfvF8GDLysk4C/oD09gj5iIAphv7iPChUKgqZ5khCMrVbIDPKxewvvTzPGM38fxu1izI
         88hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931052; x=1795535852;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+FyKPryUnxHupmwOSIIYdOL35FcAHgGEhz0DKQNfhY=;
        b=fOef7Ozdi3B3D38ybfkQdA7xdldp6s+PqlP8CDuayk0UbunrrjSsBFwP4eQxlgIayN
         gNYONeMpEglT1UGm1eqLdAuDAEOk2Vyscm2yr9nXjknwrdsrE5c46jAcdTpCLDWbzhoa
         Ha0x5wZ5bD4O0G7DJYSCjufZlEmuNwOaYtukdHFh/KzLOERdpX133uJOhRanwvVch5GC
         V6voxDHpM227WH2pjJTzClTLwRkJRYkLqRYNKqYckNVPCaw9fapukaqyVuFlDbDARudr
         s65wq9WIIToWaMcFuGArmVnseb5azxU2/VxnEXKiRJgLj6fhDaD3Vsy4j58Rb2kIxnJ/
         6YKQ==
X-Forwarded-Encrypted: i=1; AL+hErE9T8cwTXYIs6hCULo0uLzWntUgJVD5UKe7pRTBqP0e4DlPtw35zij1SDW22K1cEvFzGgdqkw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9kvxgEIzhIbxCP0EnkSQpQ8PMIZItIGwQ2uRWtlRqrP+tT2+Wt
	LVrSPoDl/51rOcSNh2ZRzegoAdPlVOCTXYcD3ujnu95OWoDQI28sJ3i+
X-Gm-Gg: AZFdTZelanPEsITDlkoylrUiN7jSdRJ04a03U4ctJEoILoKOf9gY4IHuemI8woLyTwR
	dwkau6/sJCLKwmlhiVGaRxuqVH4TTy2Fc3Tw6TuAeBFP/nSpLWNR93/ATf85UNw4fhAmjGm7N4q
	93KorExkbKhVlPxJAn26Gd/25WKETdx2FungPSI+fLv/W1+w88ysFoGoCrQ1otKjehut9i0iqBL
	/E/OByvVOsuO4ArofD0lManoPvjbuHI/mNrUU/GWsc7bphc0iwqZgwLyQYEoQZ4gOWrP8yH4X37
	ZTUBo9uwRNY+Yd02dRUsUm7tVJqb+m13ZI1QnLgkufvHYxHNQC9eCZGDsJYTjLDNFwBc5XEdR2B
	eSJqUBwkPDrpez/pwbGOibVA+g0tgr9DcNb4j8a88FMHc+sCk6JBV5ICKnWTYJojxduCewcADXT
	VKQ7PVNm4sXmD6o7+NYFMqBL6jKrkdvoaCymIFw0IBkKpKvQCSrWROzKDLQktS0Uq+PGbvTKdTp
	zD8iSk2gSjhZGq8m7NQPTsMbE/Lr0+aH3vfVN7m+aEY5kT2We6xeaLZv5NvU32CM/gohrqQmG0E
	00qU91kKFniYtqHFqWkCdBXT1wmw0dFa6wpPx+ewoj/zLyGI2JWxVcn9emoDrYVBau4SIuFXw8T
	K07NY9cHx1eDu9RccQjaP1iA9oG+qeL8uxnp1pfhtZa+iXdUhvjb3gZFDN8f/A0vACSV00sB9o9
	wkovEclhY=
X-Received: by 2002:a17:90b:50d0:b0:3b3:b750:d2ed with SMTP id 98e67ed59e1d1-3b3b750d6acmr2306459a91.8.1794931051401;
        Tue, 17 Nov 2026 07:57:31 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac6016c3sm4692320a91.15.2026.11.17.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 07:57:30 -0800 (PST)
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
Subject: Re: [PATCH] mm/damon/paddr: skip hugetlb folios as a whole in
 pageout
From: Aveline Noir <jm5905938@gmail.com>
Date: Wed, 18 Nov 2026 02:54:30 +1100
Message-Id: <179493087012.57245.993362683540368479.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev
In-Reply-To: <20261117143352.121497-1-sj@kernel.org>
References: <20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com>
 <20261117143352.121497-1-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Tue, 17 Nov 2026 06:33:51 -0800 SJ Park wrote:

> > +		if (folio && !folio_test_lru(folio) && folio_test_hugetlb(folio))
>
> Why do we need both !folio_test_lru() and folio_test_hugetlb() here?  Could
> hugetlb folio in lru list exist?  Could folios not in lru list be reclaimed?

Yeah, you're right.  Neither is possible, so the hugetlb check is
redundant.

> Would only !folio_test_lru() suffice?  If so, the patch subject and
> description may also better to be updated.

That'll be better. Thanks for your help :) I'll fix it in v2.

Thanks,
Aveline Noir
