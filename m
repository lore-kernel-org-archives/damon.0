Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD79D531
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174036; cv=none; b=Zi2hCAGBAXKaU6YfoAWBy5w+Amgk8HSMEuIXdAgG8qtAWL0e+6/3ppy+xVBepQ95TpfG0IAo30qpLSkVR+461WLml+oTDgG8DQ7xG43ur5afyM8hRi/ZGk9xB7gtmiCaoSpXxhtfKeITmXZbfRvGN1FnIA7o4HspintWJOH3Tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174036; c=relaxed/simple;
	bh=mhPJ/wBryYh+tBKrzc/jZxT3+yJ1H/IOQdfg+3UYVRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/Lx3NGzkoaBb09hA5fwgQ3NWr53jw7vQGYTiAISnf981OMOrBkU4gSKkRlvOvzbzqC0R3vMcIdrqck5Nr8vlCohSGlat9azZzXrfdjA/aKos21xO5orFeeu/g7sPdtDLcahvJ1p8n+/bT4cWvoDULOfE4ccuH2+sNiIbkysJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwyJV/qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwyJV/qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B971F000E9;
	Tue, 23 Jun 2026 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174035;
	bh=3WdpQ4jQUPQHBlshMBxJbtEGsmsoGpVBFVXFsi5ZE9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IwyJV/qgVsTXXMQsIfhryux3KRN6Mn+HUf72Ydmy2PVvpIKqGa3MU+axOm0pbWPsS
	 Ur3mS3eElNSPjTSrR9Fm9FwS6UBDOSUlQwaSRUXTohEHTtu1WVX1sNFvQPAUvlSSZS
	 kX4IwPvuQ0xVrVwf1bMCFYFpABh2AUkipbEv0ju/nEiuTmJb8ALT2x1T1GGO9D0rS/
	 Cw5aUUDcpOWvQ5MB1yjQEzgaPRJTrQSc0GsADjDVHUfPtv6CLGULdxtAQBT7s4awCx
	 TYrsUfFP4WhJCTMN+E5EhoARJxvROw/cQtVRFGQDlbHJI9MhoRQcTddzVe7rZOa1WQ
	 F6YIIBJkGw3UA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 03/18] mm/damon/core: always update ->last_nr_accesses for intervals change
Date: Mon, 22 Jun 2026 17:20:25 -0700
Message-ID: <20260623002025.35443-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622143713.7ED1C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:37:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflow in `damon_accesses_bp_to_nr_accesses()` and `damon_nr_accesses_to_accesses_bp()` when interval ratios are large.

Known low priority issue.  Not a blocker of this patch.


Thanks,
SJ

[...]
