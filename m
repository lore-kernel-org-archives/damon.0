Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2157AD2C;
	Tue, 16 Sep 2025 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002102; cv=none; b=Q7tANNuP2TAXor4qD2+XdYNW3qZzsNUaWPVXdVK66RpvdLCptLyqG9dtqdKSZSoorQIxHwgfcqYctxP4GIWZAtPr4BsHmZkS62MpnIHzW61vn3Vgumr9x6VpJH6nwRNf9pW2rGfMMXxWcRZ6te9aR6i3Txtlz0iiTqYm7QEzXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002102; c=relaxed/simple;
	bh=G1s+w5/epe5dweVcgrOSpM0OcqT3aFt3572hnVdOnOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ra9waP50wq/MFivn0db/4pNFtUtaMr2gCHQW+e2q0RgXCskktpU9iNrYqQmgcR8DEDtAjfSiIVSiz0YXeWZI2QHPkTxBAATMC+05PrCSeC9l6xmG5AE3IwdL191uXZt1hNv8k4Ekqz4vOMkj4TZNwdpMYVXwoBbXvA66HWs98tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X65Ls3C+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X65Ls3C+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321B9C4CEEB;
	Tue, 16 Sep 2025 05:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758002101;
	bh=G1s+w5/epe5dweVcgrOSpM0OcqT3aFt3572hnVdOnOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X65Ls3C+eQ/thh83WoE9yI3nadq4ds7VGgb6X+0TnQ1j4cm2jIWFXYSuyHhjta0zw
	 JA9nyuqVKM7o/g5oJes8OMPiUHmD4x4NPSmqHklfErth3+ggkiKUz/MrG+WDA8FI2o
	 maXklA1mRL3PSO4HBPfpH1FQ/kqkdcNr5W39VkCCgSo+4CvRoZzal2gzjVjK2jiiHr
	 zMqdZwGMQ7DLt0AQIBk3g1lF2EMbhpXvZITWx5oIqXS7V4wFyFcXhi8FKX/3ar022y
	 UHLkNt2Vj0I8FaK8Q8+UwCXaH5wIC/1PE6+rG4DlYwErkfan0bWJagg+wFH1zZwIIT
	 4jlxL+oWvqTfg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: define and use DAMON initialization check function
Date: Mon, 15 Sep 2025 22:54:57 -0700
Message-Id: <20250916055458.118498-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915213312.12892156442f3a795a0a01f5@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 21:33:12 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 15 Sep 2025 20:35:04 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > If DAMON is tried to be used by its API callers when it is not yet
> > successfully initialized, the callers could be crashed.  Such issues
> > actually happened and were fixed [1].  DAMON API callers are therefore
> > having their own hacks for seeing if it is safe to use DAMON or not.
> > Those built on an untreliable assumption that DAMON should be ready to
> > be used on module init time.  DAMON initialization could fail if
> > KMEM_CACHE() fails, though.
> 
> Wait.  Is there any realistic expectation that KMEM_CACHE() will fail
> when DAMON uses it?

Not really.  The commit message is saying just a theoretical and unlikely
possibility.

> We do have the convention of assuming that
> __init-time allocations do not fail.  If they do, an oops or panic is
> an acceptable response.
> 
> Are these problems actually real-world demonstrable things, or has
> someone been playing with fault injection or, ...?

I don't have a way to demonstrate it.  The commit message was only for
discussing a theoretical and unlikely case.  Maybe it was better to just not
mention.

> 
> > Also those are basically duplications that
> > make their maintenance difficult.
> 
> Unclear.  This means that the client hacks are no longer necessary after
> these changes?

You're correct.

Sorry for the poor cover letter message.  If I have to post a new version of
this patch series, I would update the cover letter message as below.  Does it
look better?  If so, could you please update the cover letter part of the
commit on the mm tree?

"""
DAMON is initialized in subsystem initialization time, by damon_init().  If
DAMON API functions are called before the initialization, the system could
crash.  Actually such issues happened and were fixed [1] in the past.  For the
fix, DAMON API callers have updated to check if DAMON is initialized or not,
using their own hacks.  The hacks are unnecessarily duplicated on every DAMON
API callers and therefore it would be difficult to reliably maintain in the
long term.

Make it reliable and easy to maintain.  For this, implement a new DAMON core
layer API function that returns if DAMON is successfully initialized.  If it
returns true, it means DAMON API functions are safe to be used.  After the
introduction of the new API, update DAMON API callers to use the new function
instead of their own hacks.

[1] https://lore.kernel.org/20250909022238.2989-1-sj@kernel.org
"""

As always, please let me know if there is anything I can help.


Thanks,
SJ
