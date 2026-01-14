Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6A36C5BC
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372255; cv=none; b=SkokY+84x5e2E1SPATwu51cV9Pv7zOhcXLhxK6pn3jzJyJdm1IXxksms7r1yJ/qo4mt0ooeelzjyid07Nq+Hes9FPPh/ZYz8zkYmCTbWl+X3B0JKHSMK3c/G25GrJYkUYW8RdNXe49b6wnoYQVywxNytW/6Ef+yGPSMhi9qsKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372255; c=relaxed/simple;
	bh=wsT/ZmfFtzhm606qNq9BAjdXFdDwemXIaKcdGEE/foc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPD+9A1HL6Ko+HNXmdVGOND4npmrfcr/Dx03dDjZAOQreXpKij45LuUSATKO8FkuJDEB0BPd2e/QwVC31LtkcgQ/ZFf98NDPLvPwyzanBWZCGECjrSBuJGGKxF7lPqSZsGtayicczJHBTsuL8s3GBoKU3ITWVwJ3fI/txz1Pbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAFNKkkD; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAFNKkkD"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2af41f558f5so8833805eec.1
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 22:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768372246; x=1768977046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsT/ZmfFtzhm606qNq9BAjdXFdDwemXIaKcdGEE/foc=;
        b=jAFNKkkDXGgysxTEDCaQRKWPIuwZ6SfiB9+w+B2KhvEg9psW3BhvHuV7aFEVtnvOUK
         sO43tBD8f2WR9Iz+7kubDdhrLcuquxb9al8x8UaL9AKcO3PcIIOePRCH5IcoLTTg80VJ
         na7fZy5cxg48KaIuFi6SWbuPCqKQfwJKeRxyJSsRoB2y/OEpxbneGZMiB688GPqz2kUj
         g5OUPYZgRozBiG3GE9d695pLLwYaK26KTxgIRXOX04zGWJg2pnV+RhDn8jmTY1IW5Ljo
         WtHucHgW7fBOnWc0evnglIOqUNj+UHn/7dC3XKMvk2YdZW4uu8DHIvGdXN97O1/oZZy9
         nORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768372246; x=1768977046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsT/ZmfFtzhm606qNq9BAjdXFdDwemXIaKcdGEE/foc=;
        b=Cugjve6ZxqQsF2qCN5nX4zL1642Km8l3ugOoE+0L2Xa3H2S19Q7/is/1NqVxgBxQkA
         Dr85TxN8xA5t/2WlmrcpMfXju2oKnaDYIHIz5Lx1Vp1mat0foEtritYfILc2qNZ/VoFO
         bOB9BcGMRU2V0+QUEKrhV9W9bo9jzL/CfRdpi0qj7LRk5Xvhj3bC1fbU9r9PFMULciZW
         FvDQsTZ0QNblv8A7t2gCCnE0tQSjLx7Run2zS4JggFqCovQ3TYcaZeqyPFRdemwuR2eD
         lgDSJ5zdaoIv1HzuIaZPeWD8OFuOtJse0bCNC+gE7nT3xIBrSdBN7bsKE2NAy3hqpeHZ
         j5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVycGKdqIVzkMwUYm4xUPrRupUpkrEwHmpHz9plWoFH7PQKurb9f2me5Bp9PFnUupBC/OgHfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtcolHx364zrsQuTjVUnthPy2TASiLGydS/PJ3raAMnWZr4D4d
	YZsga9P3Cx8EqlSv/4e9CCKnp4T2VGsmP43lCO91gYTv69xKXiSEDUd5
X-Gm-Gg: AY/fxX7b/fCv+lD6vi2pWIrDodViCoCy64qfeVgajxlHjnu1XbZX0kR3oaJnO2C11lY
	ARNJaL+PBtJZWogVrCyVxk605ubvsibX0++uo1+Oa1RAsV3uaryr/FxSfx4M2qXwroud1tMe8u4
	og1BJei1omY53GuG22eH9YD4m4Oykpw96J87xZvR2rufT5D3AneYV9EI/5465i0vrfSlj0AFei5
	4gPjxOR8ngE9gkuxZDm3jMHxJV62IpBcC0wmICjm920xUGMIgmTztz7A6TC6u9vYEZcPIkWvEp7
	TyoEtfgA8le71026TMsj2J87VpHlbjZ1aEkvK6KIskCh4Pggt7ypUsrykKwgrjRbWkr4+ACngn0
	bMUU3o0yQLJW5rPcCfO5d9/mbsh0w1Wx6kOxfc6gryc+Q3M3LeWdAcMxbJWSSn++KHnh3s+r4GO
	f3
X-Received: by 2002:a05:7300:a286:b0:2a4:3593:466d with SMTP id 5a478bee46e88-2b486b72a9bmr2703868eec.9.1768372246284;
        Tue, 13 Jan 2026 22:30:46 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a5d3dsm18126062eec.13.2026.01.13.22.30.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 22:30:46 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 11/11] Docs/admin-guide/mm/damon/lru_sort: document intervals autotuning
Date: Wed, 14 Jan 2026 14:30:33 +0800
Message-ID: <20260114063033.88885-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-12-sj@kernel.org>
References: <20260113152717.70459-12-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Document a newly added DAMON_LRU_SORT module parameter for using
> monitoring intervals auto-tuning feature of DAMON.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: wang lian <lianux.mm@gmail.com>
--
Best Regards,
wang lian
