Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F12AEE1;
	Sat,  6 Jun 2026 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706197; cv=none; b=dQZuTMOXuCRvLMDermwcUk4t9mafX/A0cOmBJ8xLJxF+AYf+CDADKgBZWeys6+7r8F//6ZlDFnpYFtBIua6sF9ZZg9SThFTqKjpAFxyrOCOj+0CnD8E/MGXWhMxAmL2YRyj93a0m0Cadypgp/mXgaG/mSje1peiuvV3rHmPrDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706197; c=relaxed/simple;
	bh=xPJpsk4fCWhHFLotY9Z+aG2/WSNeKHLmHOP0NM+HU2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFWNZTePXhFTzJ7NnuodbxRMqjIf+oCmaxBsOTS1wP6q/4keSTOdCH9B4L6c2gKSa8zr55Pr7hLUAWlUuevWk0qat2Vf/l4QkELpC5xD/RKUzzcbNMDlNJgK3s976JIg984NQ2oqnPJThGvfd0j2TR8QOPtFYniW8oEqJQtr06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw/vLaTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw/vLaTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C481F00893;
	Sat,  6 Jun 2026 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780706196;
	bh=if7f2i827CYYs4L2MWjOunPYSfsBUmgkGAdZ7VFnG54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fw/vLaTXL6yirNSzNZu4/QAtzAszDN+U36IQdoYEJdWbuAk6oju9WLGXzn9xi1DvV
	 sedxmaFJCY7H4ijFitBnuhKd4PYgEsKAwWwuOAWB/cVZ1T9tr0gbefFIDE6qZ6X28J
	 PfH5zCrVAQte3BUWNF58USZTO9D8Z/qtLNORH61oX6wXpcTd6PgroQj2Vz38GAVqWf
	 hoen9t5E9ArWsx21uZevAez1HHKtHY9uQFKSP9j77izBeZZ0t6YOEU/jSrFSCPHzNK
	 JopifGHCD99GzXSM0UHfQ+asewWGBkQzzLvXqwb4VSZC9JA1hvxaiggSXWpnZmbjFh
	 nRbrhGpiyUg9g==
From: SeongJae Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon: add regression test for damos_walk() vs kdamond exit race
Date: Fri,  5 Jun 2026 17:36:27 -0700
Message-ID: <20260606003627.88973-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAF+TLO0TOKr3nef9RnbBuZ8A-jNpV1po26t1BO6JbSqMhfABvw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 5 Jun 2026 12:44:50 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> Hi SeongJae,
> 
> Apologies for the delayed response.

No worry!

[...]
> I agree that a KUnit test is the right approach since it runs inside the
> kernel and can directly set walk_control_obsolete to simulate the race
> condition reliably without timing dependencies.
> 
> I will drop the userspace selftest approach and write a KUnit test for
> damos_walk() functionality including walk_control_obsolete. I will verify
> it fails on a kernel with commit 33c3f6c2b48c ("mm/damon/core: fix
> damos_walk() vs kdamond_fn() exit race") reverted and passes with the fix
> present before sending v3.
> 
> Regarding other feedback:
> - Will use correct commit description format with subject in brackets
> - Will remove the Fixes: tag
> - Will add blank line before _damon_sysfs import
> - Will add changelog and link previous versions
> - Will share revision plan and wait at least one day
>   before sending new version

Sounds good.  Please consider using in-line reply [1] from the next time,
though!

> 
> Please give me some time to study mm/damon/tests/core-kunit.h and implement
> this properly.

No rush, take your time.

[1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying


Thanks,
SJ

[...]
