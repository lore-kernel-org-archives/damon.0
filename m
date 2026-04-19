Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074B40DFC2
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776563406; cv=none; b=eM2yLNO9qp56gSFXLzWcK2iqKjzYDmCYY7AmMTXDSSV4Tgf9JGzho3pMFkO/eht5kguTyXbysoqH8nhxpfh/qFxzQQkoB6VyeweoI+6T9wKarN1ZW7ZI79BC+2GeSph7N/LHWF1I83/O45B4/2yFWskjo//UNyxYYYe9y1gfY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776563406; c=relaxed/simple;
	bh=PdltAUMgpRRwGEPqHHmGrxGzTgYY6sulnbYO49IyA0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2PyKJ1bquSFaO3pMAAFIduY2uQWL6hmTLbT7SU4wl9rRgyw1ZTydu/UYoH47BioEzFCGgnhjJuid2Gh9fJueckzQvx7noK7Wn5zZSmueKAWOU7U6SFZSfI1Uf11JNFO6wYEcvnht0l1SqoxyNgZ9PMGPgttWfqsQbYtnFmkOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR9UpRx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR9UpRx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86597C19424;
	Sun, 19 Apr 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776563405;
	bh=PdltAUMgpRRwGEPqHHmGrxGzTgYY6sulnbYO49IyA0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tR9UpRx2sX/+FpjIk0dhjR3uZIL8PTJu4836bUuTnxZEBUWNqhtah8iOr112o6dNQ
	 42hcYqjt7wZKRbMP35C5ldRfteLXh5+zBo1pKp3VrbJNiGL7fgh/e9eC6gLoU6U2ni
	 3u2VSxUBMDq5swtIprNQovzoVgRziZwoj9Ka8cRVk7Ac1hqSv2/MNiufsjqYgeG59u
	 CP+UACx/Qy1VC45MUhzitibWvxkwVuwZcoFu6AcgliwwDnwAOo7dP03Kouy/h/D8h1
	 Nn6dOxJQkB3pKxCruVlDRjTTaktndPmfwENNO2X+LC0drBz+HaSljl26yFZuJlrhKk
	 OV/rEu3c6xOgA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 2/3] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Sat, 18 Apr 2026 18:49:53 -0700
Message-ID: <20260419014954.991-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418232932.5CE8CC19424@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: no blocker for this patch.

On Sat, 18 Apr 2026 23:29:31 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Writing to the `enabled` sysfs parameter causes a kernel panic if the module failed to initialize during boot.

Good finding, but the bug is not caused by this patch.  I will separately work
on the bug.


Thanks,
SJ

[...]
