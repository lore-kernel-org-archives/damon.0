Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C8496D44;
	Mon, 21 Sep 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008822; cv=none; b=Iv2WC7Nbp6LAQey84esI9v63pf/CFy9kIaejGunepjvMbVda8uixjqRKosZHNk0vJpTAzagQdlzMuPanFHCFhLRavZIEfsh743mPBn7HcWtPfb9BxtlsowuX//E04UX26GSBuk61BB6bmwcE3bu2lThQazox5w5xH7FsVbj9Th0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008822; c=relaxed/simple;
	bh=nfKRd5foSGMmmwuF9erGcmtGheZ7WAjUe3ko3nRBEEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBR/NqWLGoVaoKX3Q3+AUBLesMwqN4Je1f5DucEL/krbUFkVnxYnQBahvhR+EHOUgNRCiqye+njFvdNbxuSj5i0wLL8COG3HHzoZl6aIHc0OWNgPY8AzEZ/cKceHIm8A3uTwDC8vEJFRRUeycVreVw+jXU2vvxhzP202KRqcByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ProEswfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ProEswfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9598B1F000FF;
	Mon, 21 Sep 2026 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008821;
	bh=5W8BmDB0NOPitaJzU/9lbnlRA3uI3evt5bZTIrqhe3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ProEswfTIrZ65l7DvejWYIVp0UuxwpWF9GPG2r+Y4vn7rwz6OBi95kHHkXrYY8ZDH
	 Dbdl0WWVN8Gnhady5M/ullor4Be4aAImZlxaxXlYiE8Ot/J/DYa+Z74YDSjplyKJ4S
	 YjvwW/1DV6k19vciFAEfRvgt2ZFAUr2ux6+Ojspy3AJ4jF7OhZqMhMljyifHR69nhX
	 RUqYEBBNr1WQCINsMP4/jMYeTEBu1u7dtoafRvhWNcmSfUS24OffEej94xDCAHiIId
	 PmItWeWsZ5LV8puKOkTQeSgyHk7n4kD1p+EpnQt7uj3ksRsYMdV7ec01tbZ8/HfgBc
	 CFbb2kdH+bn/w==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/tests/core-kunit: test PSI goal values with explicit samples
Date: Mon, 21 Sep 2026 09:40:17 -0700
Message-ID: <20260921164017.81642-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921020013.33105-3-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 04:00:13 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Test the PSI current-value helper with explicit totals so the result does
> not depend on the test system's memory pressure. Cover an unmeasured
> consist goal, unmeasured temporal goals with zero and nonzero effective
> quotas, and measured rounds for both tuners. Check last_psi_total after
> each call.
> 
> With the old unmeasured-round behavior retained in the helper, the
> temporal check with a nonzero effective quota fails.

Thank you for contributing test!

> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
