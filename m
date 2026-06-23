Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A533D79E9
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227313; cv=none; b=LuoEkfmJHeK7gYyB+sHiwOhfD367VGZiJu8tOrVTITE8TLbbmspl2U69OdyMrfhvqbNsoZOklvpDTaRmS0scazW819a0WNS9o2p/72kNcGmXg2Af8NVOP4lVzY+FJRr1MyFmRshOLSXDOp8q/xLukuqhyJEoSUYn9R0MLrZbCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227313; c=relaxed/simple;
	bh=eA22S7AGBckEXe++FixBnCgadcCAvj7EGpqEo2KeCvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am+JrhRz/HDr4OpS2TX4gTyNh7Wqb/6YooBtLFltmf1r9W0P00r3MR4LABUts0MclACZNotKIV0e1Dcs6jEQVC2FztQxgFmn/XfA7bEmwdIpqAh9aqt52k4hNcYOK66fJ0KdQrObJcIW3lltkewt9l6l+BwyeZIJhthnfMtSWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvgsfIQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvgsfIQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B821F000E9;
	Tue, 23 Jun 2026 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227312;
	bh=IsPkCi0QPTNQLoR2JjyNkzBkj7rjBnifBSCbQQK/kJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvgsfIQcsi7SzcPcl/ALNA39T38kWHHi/EPSb+/cBKqhIYOoV83n8BFTQK8aKTyoc
	 J/uHcJdXBejAA7wYXuaK8iLncRL52BS/kTzO1jzPytXfm4efVd9SDGf9dpjG2EaRcJ
	 JRODm5SO9xQaiPlo1zRUy1UigD8gtamsH9Bxq65PE8vFiFw6X71uvHqzubAmBYQbiy
	 Xhgm067gkg0gaNPQVCcYNCaXqJRTeW4EC2Z8a7UaHvip92TxWW17wozs9rGC961qA6
	 A1S519l3oLsFOPznepiS4udolKO0fUBWpIn0/ty4721HREqmtBFnAMHJMANB7eFDXQ
	 AEhQ1fzLwAeNA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/ops-common: handle extreme intervals in damon_hot_score()
Date: Tue, 23 Jun 2026 08:08:21 -0700
Message-ID: <20260623150821.74292-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623141527.044D11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Jun 2026 14:15:26 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Multiplication in `freq_subscore` calculation overflows 32-bit `unsigned int` for extreme intervals, reversing region hotness prioritization.
> - [High] User-supplied sysfs weights can overflow, resulting in a bypassed division and Signed Integer Overflow (UB).

Sashiko acknowledges both are pre-existing issue, so no blocker for this patch.

Also, both issues happen only under extreme and never common user setups, and
causing only DAMON internal behavioral degradation.  No critical issues like
panic or memory corruption will happen.  These are known low priority issues,
not a blocker of this patch.


Thanks,
SJ

[...]
