Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66359313535
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174360; cv=none; b=Nz+t/BD1irQZl9nFRsU4uT2gqqlseKYsdvoj5kBGzxO4YmM32qheHFbRE1U/gQK9D931MJeVgV6MRTIPoo8e2Ycj/Ux+Jd01syL7MHJAHPr6N1F85+0yirDBJM5Vx6OSrWeSR4nfuSBVHfocZBCWLpiDywI+/X/JeZ+6Eeo/GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174360; c=relaxed/simple;
	bh=ZH9I0bUOz2sc6i7nL7rI/vvYWqenue4B0CwTmfhfaHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cf/1UxhELuTVpd6BCorKvIR6dpKFjIgP5EV7aPuWwB0E+egimBc83dX4GM+/188owArteDIG5viVhjwEupHA443AEUdCsgI0Mp6fjEkCSh+xA0022kPdWmdIfwpaP5Wm68sFlvRbHcGJlw48w6MmnzL2/ul9D5QBPMSLlfkRff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/FoubbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/FoubbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB101F000E9;
	Tue, 23 Jun 2026 00:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174357;
	bh=vDJTC344nEo+LfQbFJqWN1ic2ouVkEuGom1CK7uq1zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d/FoubbP2R1QJNWW/YmDwt/1QFdFxvlCmWdrOa6A7rS6lvtqT9R5GYArjpwGIFRJ3
	 0IxAuztGEDfr53V/LsuRCx9JA/7p3XRVbIUKx8oKvju5K/CfTQexx0cGsTD/SB+dGV
	 TTQdebE0O8SsN1l5ABPhia7Mij1CztlYthCNcEB/BRowXcaXXvpkt9jQq7ZMfP/70p
	 Rdbt6pQJdjnovYbWcPwOo5NZUCCY7rLA6hdtVBbhOnhuZM8U/LWT9lzlROjmoEdwno
	 oR8c1fmFwdgyj27oYXIT1o4wfNBYgNNSUF+lYmwh+kQmgsGL/M8oSngc3Rh6PvORIg
	 zVKbWbi8wu3qw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 07/18] mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
Date: Mon, 22 Jun 2026 17:25:45 -0700
Message-ID: <20260623002546.35827-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622143621.84B9D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:36:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Integer overflow in `mult_frac` on 32-bit architectures when calculating `left_window_bp` in `damon_nr_accesses_mvsum()`.

Known low priority issue.  Not a blocker for this patch.


Thanks,
SJ

[...]
