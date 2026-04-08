Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930D2F39B4;
	Wed,  8 Apr 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656490; cv=none; b=KjDb1w7+m8OX79QqjvYhCZRBPLissOqGxP7PvDJEqYkBSNDz8BlpZz/FxtvYEisvs5YnJuXx2sV4BfqLxb/DZMFPQi03Mf0eRqV1KALIAeszHlVGkd4+wGLXAOZbCR0qImrkjurhTxpTYNbQDqCNIRf0EQM3OqxBLqYwChRVCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656490; c=relaxed/simple;
	bh=ROsaxkUmsK9dQT8Wi+iwtU1tPZYRdlLs0Vtp0MHNi/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6288KqpalfCZJ9PoNcwrmhLUNLSKhlV+ErqXJDi5w5FvCN//8cCXPzq+TGMvlWPfwhXs8K2HwVieqs+xw3o6DdlG6ZzmcRLNjQ9jaOBFIq4mzk1kjlOwNHEhKuGF8s+rtIGBANAVDyvFfjdLYpHKxs+JFKELZnncvKCb3rqg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRa67WlT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRa67WlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B89C19421;
	Wed,  8 Apr 2026 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656490;
	bh=ROsaxkUmsK9dQT8Wi+iwtU1tPZYRdlLs0Vtp0MHNi/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRa67WlTM5SuiVWoEOlaqi06yAIr+JapoBgqqErFeWIq66QdFKiC+C784fxuuzHvd
	 HCeLxllrOAR62N7GZEYynFMLkxyIarc+6APAOml+UoJPiugNPy9WZVmbMaMmgp9yFc
	 I2x/YXVZQvPEpB6xgU3YbHTvl5U309py8okXl+l9bLc61l7M64uzbA7/nNTaHvSlTd
	 qmTsf70+/7ka/96rvClfbcrFVy090CAETx0FoQws3OxoPWtFchQ3EGpSrMNH+E1U2o
	 GagdUFNtJ8uwaOK5rqX354Ybp5N1P1NfjuBf7Os417JnMR+iOhoK4ggBHtZdSeFDom
	 grp94QcXnoyVw==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: (sashiko review) [PATCH v6 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Wed,  8 Apr 2026 06:54:32 -0700
Message-ID: <20260408135440.88978-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y17YnrOe=UXWBMKJ1U6seKJuauDqAdTDYo1cCYnrP_vSFg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 7 Apr 2026 19:33:43 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Tue, Apr 7, 2026 at 9:05 AM SeongJae Park <sj@kernel.org> wrote:
[...]
> Yes SJ. I think we can make it work with single goal now that the
> below commit is part of mainline. will give it a try and post an
> update.

Sounds good, please don't hesitate asking any questions.


Thanks,
SJ

[...]
