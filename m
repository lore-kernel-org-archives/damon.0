Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11230F95F;
	Fri, 20 Mar 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972911; cv=none; b=jo/9WPHPUb7fCHChTFDV+tTEI9lMBedF3AUdBOyfxGOTtOm1wiIuGyNWZ6DpvXFEzAOEB6NSwjLTE0qduXyGhJ0Qk+W4RPh1FJSYGXyb3zY9Y3b0RS51rlBW0iCEOqjb92mw8zGgkeYLrbjSITDPI8OxmLqFlSpxMf1p9V6y68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972911; c=relaxed/simple;
	bh=nj91OD/B3CaoGL5ifggk12G98qexNB5Stq57IP49ow8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BITXdM7xvmX5by+lOayuY1FsN7hrBxHQzuV9Vaka9dm76BBWS4dQmIzJnFBj+rMdplolgHkeEaunvPjlCouh1wOWuU+MP0qpQqXbJ7Aq7IUCKSB0l41Aw6vWqldCeH48cOn9Rezcwiiet/uhqUfuimPw6AvRGtT0vw2IaxIH1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAo3I+oZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAo3I+oZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB85C19424;
	Fri, 20 Mar 2026 02:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773972910;
	bh=nj91OD/B3CaoGL5ifggk12G98qexNB5Stq57IP49ow8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAo3I+oZMyMgowz7lNyCkY/wqU57k/nnBs3kw9VYAnH9pQgm3VQMuoFsKfxXemz+s
	 NIvzZOtGWwqsPwDFdj8n7r3sMFPrn1Qr+LVXyaZcNAGSbA8U+sFWoNfZF0zLVe10vE
	 BhT4Sk59E8YgWH4sRiokHiN4fvoOfe94Yi5sGkDzcyFZKuvlgpypvTr2Hie06fJYA1
	 4p0lPIh7SdYKjMnA6P7gStFCS6itCfXiVHud/OlPr4F/wk+kLdgWFmBcVreQHO+vb5
	 gVnO+I1lXRVjH+7WqvzO/umATDqc9elbphM7G1fQSrM74th5pQabkS5GqY34CQY2vi
	 XRl7oolIitQNQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/damon/sysfs: check contexts->nr in update_schemes_tried_regions
Date: Thu, 19 Mar 2026 19:15:01 -0700
Message-ID: <20260320021502.1218-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319155742.186627-4-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 15:57:41 +0000 Josh Law <objecting@objecting.org> wrote:

> damon_sysfs_update_schemes_tried_regions() and its callback
> damon_sysfs_schemes_tried_regions_upd_one() access contexts_arr[0]
> without verifying nr_contexts >= 1. This can NULL deref if damon_ctx is
> non-NULL (preserved after stop) but nr_contexts has been set to 0. Add
> the missing check.

Nice catch.  This can be triggered by privileged users.

    # cd /sys/kernel/mm/damon/admin/kdamonds/
    # echo 1 > nr_kdamonds
    # echo 1 > contexts/nr_contexts
    # echo on > state
    # echo off > state
    # echo 0 > contexts/nr_contexts
    # echo update_schemes_tried_regions > state
    # dmesg
    [...]
    [  222.362338] BUG: kernel NULL pointer dereference, address: 0000000000000000
    [...]

Weird sequence of commands, but even privileged users can make mistakes.  So I
think this deserves Fixes: and Cc: stable.

But, this is just another instance of a class of bugs that I mentioned on the
reply to the second patch of this series.  I'd suggest fixing all bugs of the
class with single fix, as I also mentioned on the second patch thread.  Let's
discuss on the thread.


Thanks,
SJ

[...]
