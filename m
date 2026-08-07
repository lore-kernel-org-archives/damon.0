Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2B31D375
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111944; cv=none; b=SBjCw5hYYDnM4ogWbR9BQPFP0exkUaSWVj1JrWNbaCyeOrSUxEDRaeNHYuRoIj4rkE0MHcAMSjBdlwDGgn+EmKXfu5Nv7gFaUUvHr/dgzmCmxYC+4ziRWAqDKIgTTpjvbv/bByl13rWDKig2MEJIYUqyAvNvNl1Lr/GBxgR2M0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111944; c=relaxed/simple;
	bh=EX7pVoaIcfJwrscRQRCMS94+jjZQEhZHFWTp17Bo91k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQcwXry3abS/5vwLQzAOquC3dRransal2axjainjgYHjyc7Uvg3TJ6mmJTPhVMMqOMAhxHa5RXlWLJnO4vAY5AkktMiYRE0B0bRKidOZSpQC55mvu0CZNHFrKAB6NmWWDzosd63RwBlAjNaxdVrDE4yf2z7L2noIYQ+rHuUUqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovbPN7Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovbPN7Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10B91F000E9;
	Fri,  7 Aug 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111941;
	bh=6yPFn7yHkyG0BJL3IlHOeyOih//+Qc5xhI7AQ3jvymc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ovbPN7MeUrWXRmoHVwijxRr5kNkr0jDBpWovDeFk5El/Uq9R/fwk/DuQ24LXjuiMk
	 ZaYqjGQDz35SWWIuxQ1LBMKsLr0FYsl0/QGUCa4H7S5OKOp6pcJnmOvSbUCtgcjHQz
	 E+CAXq4rDRN9rVU6YIdnaMB6/qYwOJAarSL4EnSis9d2aUmMzQ9yW9sXu29ntXfJKx
	 LRUH0rvCQary2ZaNedV7qjHLIXkZEaBAOuaYEt5oVMPLP0HyEo3ZcImALOid5dYDvO
	 HadyE3D7PedAhgqQDnR1C0IGNNwtLo78gtOO7utY2lJXmttPDM9CPBfA8awGC5rtdY
	 aZJ9W6Ahs7HNQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] mm/damon: fix nr_snapshots semantics and max_nr_snapshots check coverage
Date: Fri,  7 Aug 2026 07:12:13 -0700
Message-ID: <20260807141214.91390-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807093526.183009-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Fri,  7 Aug 2026 17:35:24 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Both patches address the DAMOS nr_snapshots/max_nr_snapshots
> deactivation mechanism.
> 
> - Patch 1: fixes the nr_snapshots counting semantics.
> - Patch 2: unifies deactivation checks to prevent busy-loop.

Thank you for sharing this patch series.  However, I don't think the patches
are fixing real problems.  Rather, it seems the poor documentation has confused
you.  Sorry for writing the documentation in the confusing way.  I commented to
each patch for details.  If you want, please feel free to send documentation
update patches.  I will also try to find a time to do that if nobody does.


Thanks,
SJ

[...]
