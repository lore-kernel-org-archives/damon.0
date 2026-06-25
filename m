Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952E2C11F1
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782357969; cv=none; b=LmgB2K5ZTR4BgnJUW87kJRs/gcmTS4+4RvZrrkluM3wmTW5HTF+hDrQ7XIk5iM+Ro4FAFiXtAW9GePqVQNu/Z+Ame4wrFfOmVTQ9rQjna1rcYqb1GRPyrc2a4+6aQjBME9l5WNHRJAR1ZCIP0TcJkB0ec9pnMJxoDt83Dm7OJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782357969; c=relaxed/simple;
	bh=l5ZhWwmT51xjG8WlqqRT24Nb+kxs0JXqFcGECao67PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sukF5eFYC9od11jfz0Y4bkrXJfbL6YEoX4xCSPIIvgJ/XbQtU2xsZkvYy0m+M+H5ncC7xzimXSrWmeqcBeVWcg0Q5s5aHX111xiJlJD9+QFYN8BolzU0g/JuYJ23XKUxJTX3hYE3l/pzeQnRW3iys3aNHi3dumlNM1QOhlXzOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAgsbcar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAgsbcar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127A51F00A3A;
	Thu, 25 Jun 2026 03:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782357967;
	bh=6Y0Q3/528bgziQiUg/dWP+Ff0XKFOhQqC+1UMtwPYFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAgsbcarZi2mB4JbypJL0I+wFSuZpNpkogQ0RAipzEmz+kddIFeTTo6qKnJMXoQUo
	 OvueY+43IsnOveBFmd4LN7ZDRBhIzTD6W7nVmX/RzQhv5FUZmN27OE4TfaST1mq54J
	 hCMcQTo0jpE5TS8ppHDq95ufQkvAF83DuZJmXyOMW44/0Rihc0d8nleSsNh0feLErC
	 ChCURU/HYtBbVxB02eLw3mGit3nJRKCDggGj4AYaJFzkGYzDDLygxOs2d7U5hO2HY3
	 PkqPmCff+RIhXQNhMxBolTEe77uhIL1zw98aOeNAuzs0UsU3e4WRge09bcuverNi6u
	 9chcrz1wCyJ2A==
From: SeongJae Park <sj@kernel.org>
To: Yu Qin <qin.yuA@h3c.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/paddr: remove folio_put from damon_pa_invalid_damos_folio
Date: Wed, 24 Jun 2026 20:25:52 -0700
Message-ID: <20260625032552.97468-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625012201.2937854-1-qin.yuA@h3c.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yu,


On Thu, 25 Jun 2026 09:22:01 +0800 Yu Qin <qin.yuA@h3c.com> wrote:

> This boolean function called folio_put() implicitly. Remove the put and let
> callers handle it explicitly, making the get/put pair more clear.

Thank you for this patch.  I agree explicit get/put pair could look clearer for
some people.  But, to some perspectives, doing NULL check and putting a folio
that already determined as invalid may look awkward.  Given the fact tht NULL
check was already done inside the validity checck, doing the NULL check again
makes it even look inefficient.

Maybe just a matter of taste, but my taste is unfortunately closer to the
second perspective.


Thanks,
SJ

[...]
