Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAA35975
	for <damon@lists.linux.dev>; Thu, 26 Jun 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951713; cv=none; b=NsMWQRCpE+UJDfIrVUYZnNn2TfXDYoy7t7mXamUY+hSgBWaPQUBBGX3SHqJfcaB6R24gmu6hNAxeDr17CLBPteRU0dXJhUAysrxZuigeLjHNZrFjVY6IOWmbCKAbfT4OpzPFk69MBzqVdQR7QA1ouxwlSMkmrpXeeIqjA6uJnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951713; c=relaxed/simple;
	bh=Uu8sqvmZyXrE1kN2/RgK8A1FCSgQaEwpHMcebT57S94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as5UBrCQl7wHev0c++yH+sIG3dN0Osw8GiSS6YLOmM8TMZEmzSu0RyJN+pU2kMB5lAnvW5t1q/IQTQjzbU1MIRdMdJrDpMDGyxFXW0E6EMyZqvMJtU1FnmISd4PigE30DwO4qH2VcdFwAJ05mrgTZO8JRk7WiX2ZnFsrsrZyUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRZnRhGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRZnRhGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C833C4CEEB;
	Thu, 26 Jun 2025 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750951713;
	bh=Uu8sqvmZyXrE1kN2/RgK8A1FCSgQaEwpHMcebT57S94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRZnRhGykkYDCdTWEPjsARQ4+lF+CmaRDNezz//PgaJyrI1HiHAjLCFU5IbOyyWWa
	 hdBo/izJNuG4YnHA6Tz/NKU1ghCN8tb1Evum2nW6DavtzlJi7nTFgkgc/qQ1Nt5qGy
	 cvPfTSNdeFRVkC5TkpSIgaXRJIrv8ZA2skZ05WDy+GQHlCwWq1Kg+CLqnleZuQ6Cql
	 61oQgOocad23MINKhuCsO3m1uu6G1MJx9hg9eLO3pNQJg00a77GHHRGPMgqGfWOK+2
	 9HXrCAulJeSr27l5KodVBUow1jI+l4LaJDlp7PlKjcdwBqYyKs0pRDVVGpiErMN5v+
	 w+IAvWvS7IP/Q==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 3/3] samples/damon: fix bugs for damon sample for start failures
Date: Thu, 26 Jun 2025 08:28:28 -0700
Message-ID: <20250626152829.334177-1-sj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <08a1f2b7-15ac-4677-88d8-7112f0f9d5da@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 07:27:18 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...] 
> Thank you too.  I will send it within a few days.

Thank you, looking forward to the next version!


Thanks,
SJ

[...]
