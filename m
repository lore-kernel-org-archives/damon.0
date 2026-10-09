Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33F4D37B9
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554446; cv=none; b=fQ6grCueLRrS1ez9kdL4kNkuSVO9H19AcgRILMffYXJjKZWOTFX9SgMWcUhmA7riD5mZo6mURN3aXiT41s1fCZ+jdJu+GEghX8KiHaKUkI1giYxat9LmIygsRyG+HJjBXlr+y2amSl46xD0kGg3SNAfo9yjMLiQdq1HQlORQEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554446; c=relaxed/simple;
	bh=c8YbCKHXGbQGf54+K6Q8d8NE83XQDWvkErdSqRK7yBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM21u3rDQdmAfVZsFva4Kk8QL2NkMz1SrWTxanC6HtS/uS3Wg7MZBIwueXulLPX3VV1Ndo7ytT30klPZHF8+Oaft4q8Z5l300DCSQHkVUng1v3nicszuWWbrfmnkCtwWy+8EgAslkAEItEM8pYLFogWdz68UbJKPto/hl1DfbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrmViO/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrmViO/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D8F1F000FF;
	Fri,  9 Oct 2026 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554445;
	bh=U8ZZtxpPf3ZxApZdnej/5Ho/hbGh7sjDwT8v0/08DJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BrmViO/RMIoAWkNXWo0MAoKRDlCL6fGnNr9qRSMYPKrDZ4XvQTpTbDWEtxuEZGm4q
	 kwj9XAd/xlj1NYq25K+poxGO/DIkNtaE4UekGzAlqh7E8oVaRn2ZYDYXQJJRvTdUB2
	 1toht33sXHXl4d7XFpj8kmp76YqGcbgQjWAUD+CzIbg8YgSaiyD+5+GC66k+CAMqFZ
	 IXlJx8eWXM2vAyw2Lkf3GAbK5ZfHYed9AnyNZJyehlpsAb2yogHFD+ohUDfftiVfyp
	 WzJmsJPKcxGWyHYlCsD8u0x+nXjOOGKIrfRpxNrb/Do3Igxybr7cfX417UKmh0mzwy
	 rjDM5kPtkAOgg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Fri,  9 Oct 2026 07:00:41 -0700
Message-ID: <20261009140041.11741-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009120950.38879-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Fri,  9 Oct 2026 20:08:33 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

[...]
> Yes.  My expected behavior is to completely save and restore the DAMON
> SYSFS configuration, including DAMOS Schemes.  But it cannot done by
> 'damo args damon'.
> 
> In the script I provided, it first apply lru.json and then uses
> 'damo args damon' to export the current configuration file.

'damo args damon' does not export the running DAMON parameters.  Why do you
expect so?  Has some document confused you?

> I expected
> that reapplying this exported configuration (via 'damo start --kdamonds')
> would fully restore the previous DAMON SYSFS setup.

So this expectation is wrong.

> 
> However, the current/unexpected behavior is that it drops the DAMOS
> Schemes configuration entirely.  In other words, I cannot fully save
> and restore the DAMON SYSFS configuration using 'damo args damon'.

So it looks like there is not problem.  Please let me know if I'm missing
something.


Thanks,
SJ

[...]
