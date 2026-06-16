Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7203D88FE
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588715; cv=none; b=UAqaPhCesS83tz214zWF3SJSKmwnaepJGMpQkqtHA9E+YLYyzoAKVLN++XV5boyabM3N6W3cXjA5BLm+eUo27HabXqOvFDgwBGkfKKBF+gVYKeF2Ihj4hAoSGGN83AorPJBNF5Frh+PJVIYkq5MfD6K+SDwirXGdtDumbg/ao6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588715; c=relaxed/simple;
	bh=hJealirzMpRC0r6fjzj1gFkN0RnVf7JpXe5W4PMnhSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBwfvLcTWq4X3GAICuy4ELKAtP6+bdptpb8PUOoxlhCkMHlcq6aBzobQAegolCp7UeugCgRYb8AaFqjODliGI8hKd/36Cow1UJd4MPIjwHRRMBTS5iwDJWID3sf6jTKnZQ53WwUg8I9BV+V/+Cin1txPJXpiefkCUwYPHS7SOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNmmycnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNmmycnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BB91F00A3A;
	Tue, 16 Jun 2026 05:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781588714;
	bh=+p5QsX681n6vVHICJ0HE+UqOhyGx6c8IyLFDRnHqxxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNmmycnBbAZuTAi/851k2rRz4oxc9U97LLzUJHZc6HNCmhoE4ucuNByoduJY+Z7Vt
	 Jm0xxkwlXDDiC8MY8JoeuD2Iyovs/EVn8P1aMHsCmrJxEGoGhnbL36w/yOmB3w56FA
	 YNasDmVZcQxVDahCfuh+i80R+IjDdZwxRSd8rF1s9kiWU9qneV5u/98LiqRPvljNU8
	 heBo/zaxJ9T6W0zWO5yFHqTcQlLzk1dgoY25GSJUxMmtwMcOzyXbFqJ58OFhvAZYYG
	 w0wOr6+8kv9oYQw3QvEoOxBwEIuNpC55boalFbNUsVbq0/1yZtcmFsdEE6PQlheQCC
	 sloH2JatiwDGQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Mon, 15 Jun 2026 22:45:04 -0700
Message-ID: <20260616054505.156611-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260517205828.6204-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 17 May 2026 13:58:26 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 17 May 2026 18:27:49 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] Moving the `sz_filter_passed` assignment to after `kobject_init_and_add()` exposes uninitialized kernel heap memory to user space.
> > - [High] Relying solely on `kobject_put()` to remove directories from sysfs leaves directories visible if references are held.
> > --
> > 
> > commit eda0f7269f695739057cee7bd02d81742d566163
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
> > 
> > This commit updates DAMON sysfs to remove region objects from the linked list
> > immediately before decrementing the kobject reference count to prevent
> > use-after-free races. It also modifies region population to only add the
> > region to the list after a successful kobject initialization.
> > 
> > Link: https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > > --- a/mm/damon/sysfs-schemes.c
> > > +++ b/mm/damon/sysfs-schemes.c
> > > @@ -163,7 +163,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
> > >  	struct damon_sysfs_scheme_region *r, *next;
> > >  
> > >  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
> > > -		/* release function deletes it from the list */
> > > +		list_del(&r->list);
> > >  		kobject_put(&r->kobj);
> > 
> > This is not a new regression, but does relying solely on kobject_put() to
> > remove directories from sysfs leave them visible if references are still
> > held?
> > 
> > If an elevated reference count exists, such as a process having an open file
> > descriptor to a sysfs attribute, the kobject is not immediately released and
> > kobject_del() is delayed.
> > 
> > Could this leave the old region directory accessible in sysfs indefinitely,
> > causing stale directories to accumulate alongside new ones? Should
> > kobject_del(&r->kobj) be called explicitly before kobject_put() to cleanly
> > and synchronously remove the directory?

Because opening sysfs file doesn't increase the reference count of the kobject,
and DAMON sysfs files are managed by only DAMON, elevated reference count issue
cannot happen.  Nonetheless, on CONFIG_DEBUG_KOBJECT_RELEASE enabled kernels,
the kboject deletion is delayed.  As a result, new directory creation can fail
due to name conflicts.

No catastrophic issues like memory corruption can happen, but the user
experience will be arguably bad.

> 
> Makes sense, I will work on this.  Not a blocker of this patch, as Sashiko also
> mentioned, though.

Hence I'm keep working on this issue.  Just wanted to clarify the expected real
user impacts.


Thanks,
SJ

[...]
