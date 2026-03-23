Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C4823DD;
	Mon, 23 Mar 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275044; cv=none; b=h3mp4SI5yowh4lXL6oL69z7+3psjB01Oj4XMdPp+1VyErEN+83qfT9AbyGgRfErGKY/DLmMA6oCQdTiRaHiU8runNFw6Zhm9x6rMFot/eXJ8IYOSNMSs8Dgd7iqe5TJTyuKzgTsNPXWFEnt0qj2hgcTimXIgK74iexni6ljHKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275044; c=relaxed/simple;
	bh=TuTrUVWqHjE6YuwxBi0DHWoX6gX3ScTAzVK+DmaN/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slRVDGXKm+mq0T6Ek5dFY2hZjrs8r/QWh6E+ikVIFlqdxPLeYl1VMlUhIUi3WAD/bYHqslRuBDfAhU97QYKqblNYbNxqxOdiu1kp01dAO/6uRbvbQdrtENZsmLhnDUyehnTyANWSDGtUNFtaZoHfVbSGF8VkGMf/QwMZszDAuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXNW41KL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXNW41KL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F8DC4CEF7;
	Mon, 23 Mar 2026 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774275043;
	bh=TuTrUVWqHjE6YuwxBi0DHWoX6gX3ScTAzVK+DmaN/Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXNW41KLzQ1yC6X9sBVothBySUpd3PSXV4JllhANSOalEfcpiwo6d5L0T8AZr7dEs
	 TrjheJfwildl4CcMFu95Dxp0GqYTZ13gp6N2ZVDI3gKLfI9E5k+mRnp7LfI9xV+B5p
	 F/mFAF80BasobGaeOMy1/9b4HtfluEtl0rqk39aBo5jzS09pu+yLS1ayQOBeXt/gv4
	 rylHAXIPR9aqK38aeizkcBCVzai9NpqSfrDVP+jbkYEFw8S3xPMEfjA631WONK0gch
	 7T6/mLPfYzI28GJAexJA4kEdCwj6lE2Uwnre3ov2sLvxjIkLZ2agG4pZgjb+SH21AV
	 pFFl8SDa5I8+Q==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Mon, 23 Mar 2026 07:10:36 -0700
Message-ID: <20260323141037.80243-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322214325.260007-3-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 21:43:25 +0000 Josh Law <objecting@objecting.org> wrote:

> Hardware integer division is slow. The function damon_max_nr_accesses(),
> which is called very frequently (e.g., once per region per sample
> interval inside damon_update_region_access_rate), performs an integer
> division: attrs->aggr_interval / attrs->sample_interval.
> 
> However, the struct damon_attrs already caches this exact ratio in the
> internal field aggr_samples (since earlier commits). We can eliminate
> the hardware division in the hot path by simply returning aggr_samples.
> 
> This significantly reduces the CPU cycle overhead of updating the access
> rates for thousands of regions.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
