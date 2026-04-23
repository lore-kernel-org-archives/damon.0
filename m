Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161335966
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905222; cv=none; b=Y3591re2HBneFHJNhIAewZllnma2sfAOK87cFv8SQAsr4ScjPYDEi9jyDrF6c6Py88cjI7GL/9UEYgX4NcsjpECE4RN+jZXYYoci2NIHrGOJuXx99Ir3MRjsi1xelebFTNcyNTSOBcu7pY0Or5f5sr1fz7OR7xINs0AsbL+1gKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905222; c=relaxed/simple;
	bh=BOKNkyXNf94HQGzDuXqZQO666PP2w686Mac0++U2Yvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEN085tL9US8UOOoMwF6afYYFtU0xZdEvx59XrTF5U9jD6l1owIRhfJGD+Ro9yjw3l8EmNhuyVpKkKctBXKBJZk/z0FyzW7qxxMPhekUMS874tkVxYJlaqB1jiOaX5eLzjEmq1HvZYy/O82kxjiljtPdl+WRdXLxHooAF2SXejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acZPuOsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acZPuOsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591F8C19425;
	Thu, 23 Apr 2026 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776905222;
	bh=BOKNkyXNf94HQGzDuXqZQO666PP2w686Mac0++U2Yvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acZPuOsQTPi9vu8O460kkONmWOyePqDBYumur7FO62sNKMWidUdz3KHD8xYtRdMzG
	 OneONutYaAz3MU3cM9XFzfsd8mvxByMrDqVRpQjDsIcOG2p6gEC5GecDui9N71ayan
	 nnpgMt9KkDWfGipF2wKQk4qo1KVQwiPcqZjmlB/h5ixbmzW/5BlL/wXy/0/xqQc/OB
	 PbDEnzfCbCVQmLbLxCPfM2rncf61Vy8nSwWM+YPWIzV3aEU6Y2BijAHwV9Q1OWZ0jd
	 GlpsUIuV3cUgrGMnv0y45tEng12KbQYFime2RYNHbqLgTsF0j8Iy7YCsoq+tGCLrsd
	 vsa8UkHGq/Pkg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
Date: Wed, 22 Apr 2026 17:46:53 -0700
Message-ID: <20260423004655.75209-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422210221.A666EC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 22 Apr 2026 21:02:21 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Low] The commit message incorrectly references the `memcg_path` file instead of the `path` file.
> --
> 
> commit 9335b00570732d12b29034fc72a20506fd69fbdd
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
> 
> This commit adds damon_sysfs_lock protection to the path attribute's sysfs show
> and store functions. This prevents a use-after-free race condition during
> concurrent user-driven reads and writes.
> 
> > damon_sysfs_quot_goal->path can be read and written by users, via DAMON
> > sysfs memcg_path file.  It can also be indirectly read, for the
> 
> This isn't a bug, but the commit message references the memcg_path sysfs file.
> Since the patch actually modifies path_show and path_store, which handle the
> path attribute for quota goals, should this say "via DAMON sysfs path file"
> instead?

Good finding.  I will fix this in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260422143503.71357-1-sj@kernel.org?part=2
> 


Thanks,
SJ
