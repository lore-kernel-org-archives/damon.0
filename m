Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F93ED109;
	Wed, 22 Apr 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868877; cv=none; b=EmRZw6UiXDsbVx3MNZeahL9c2x50Srly2tyI6EWO774W+pi53ptY6RQLTaDGEjzWy5VVg8QnjRKnhRdr+SMJZyI0LHipbUTKhhd3sPwIs+xHkLJaggWRTAJyIlzTXk8Wl0lUum+qwnjWkvvJT1VHnO3qXgC7GNzJDBxvcGppBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868877; c=relaxed/simple;
	bh=dPh+28e9o3rFcTZ19LGrpIKOeKqHRgIxt9m1cNTW0OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riRbT4BiG37q+0QJEdA4ZBJGHUuMZTpa6TG9FZM8In+s01SCqoXQJ4oGEaU7UWLEHs8L9CYZ+gl3FDqt4gvCUwm8aYP54W7CySQ/uqPEV2JR59c9pqRbDKgkue5bGDsboaai9r7WFmXoonda1cqOtmG6HFYiewhZsKm/774C0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uje//+Uo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uje//+Uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4D0C19425;
	Wed, 22 Apr 2026 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868876;
	bh=dPh+28e9o3rFcTZ19LGrpIKOeKqHRgIxt9m1cNTW0OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uje//+UoTKmRJ5EoGDyItpPUxlbew9QtwD5e5jcyMBDhgk5QI6JF5kJG/fdtkc32F
	 Vva5ikvKVmSmlKRS8JSCBlRVI0DuNKbeneEvZyXp3OrTg2oVeAZ0um3pFGZuPIgvXe
	 uYxLOIRnwk2IqagrOgdEoAn3nLknWU+aov5+Y3dFoWx/fFTMQFGMl69p9Is/r6zAGR
	 Fj6lufcUj7ONPb/Jd2qUvGcxFQkKCVWfWY9ZODGbzszJzOQHt6zv2v9P4c1zSi4CIb
	 9YeHwGQKivViLtoodqTQy5EpcQh/9FbHDcMTU497CxLTtBlIKgqLWEkFd5aGL4tC6O
	 vihd6xExMyVHQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: Re: [RFC PATCH 0/2] mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path
Date: Wed, 22 Apr 2026 07:40:59 -0700
Message-ID: <20260422144059.72000-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422143503.71357-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Apr 2026 07:34:59 -0700 SeongJae Park <sj@kernel.org> wrote:

> Reads of 'path' and 'memcg_path' files in DAMON sysfs interface could
> race with their writes, results in use-after-free.  Fix those.

Forgot adding change log, sorry.

Changes from v2
- v2: https://lore.kernel.org/20260420125405.362137-1-qjx1298677004@gmail.com
- Split patch for individual fixes commits.
- Hand-off authorship to SJ, give Co-developed-by: to Junxi.
- Use mutex_trylock() instead of mutex_lock().
- Add RFC tag for Sashiko review round.
- Wordsmith commit messages.
Changes from v1
- v1: https://lore.kernel.org/20260420085332.178473-1-qjx1298677004@gmail.com
- Protect not only user-writes but also user-reads.


Thanks,
SJ

> 
> SeongJae Park (2):
>   mm/damon/sysfs-schemes: protect memcg_path kfree() with
>     damon_sysfs_lock
>   mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
> 
>  mm/damon/sysfs-schemes.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 0d45806f3a75bf53e59475b0e56be324f650ab09
> -- 
> 2.47.3

Sent using hkml (https://github.com/sjp38/hackermail)
