Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419762AD10
	for <damon@lists.linux.dev>; Sat, 16 May 2026 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896061; cv=none; b=NK5XCorSq7hnNQVQ2skB+DFnovQV54Qw2soIw0nUWPqeNTyxwv5GvWl4TVRbE73J+mhBBeuPWy+DSYjvkTR50WhmkpTo0zjB4kghOT9VpYkW1puvLB7OZ9sub+TzKZXNrTl623LKR19l88pnK/jFdlkcijZqHqEVqwapz4xm9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896061; c=relaxed/simple;
	bh=IObWKJwFtuDL/u7n5lwltp8maXzIUsXuFjhbwq42lUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt76hn423LjeC3R/jeOFbaA5vAFI9NsCipa5swvEgnbKHx8YwJ7bv9o7VhmyLTHt6qhdl76LCz59huPC+RQ8qUdZwfnbh+JFKm5r5318Jdfn761xRQKdpzqkgTNa8F4RFmMp2FIe4htLkZKF30bTpwsoXJspIfm5+tkTepgPqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IszgZExl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IszgZExl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B15C2BCB0;
	Sat, 16 May 2026 01:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778896060;
	bh=IObWKJwFtuDL/u7n5lwltp8maXzIUsXuFjhbwq42lUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IszgZExlw8CKuAUGztuiio4P59JLfqgxY4pa7hOiwmViQz6bNQnmvl3+TE2y8mc1s
	 75VfKlwR//E9I42jXXXPKYTwtnBKok1jRMpa1y1dyjL7RQOVZLHVDhOpG4R0Euu3VZ
	 408AJ2v1vTX+o0H5GDhwapFQ0KqLXM8m7DGyYEfTNeWjhSpsEIa2y4pR1+V+qie0Eb
	 nfhB3KOatn7VRtFDtTyXi0zt23jPnkgIkM82ymM8WWLBRXumY7kSD/aMiNNFWd5o9f
	 fsbmYzRjvPETCGPxJ4rY0Mq66xymmyFNKo6gBaNwIm76sXGrakvfNV+cZM+hEFQkuY
	 Ypq6kguuRlw/w==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 24/28] mm/damon/sysfs: add filters/<F>/path file
Date: Fri, 15 May 2026 18:47:11 -0700
Message-ID: <20260516014711.147427-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515013513.7045DC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:35:11 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The sysfs file is named 'path', but the commit message body claims it is named 'filter'.
> --
> 
> commit de3638dbf8d1acc9d36bc5e5de54362c9f8fe540
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: add filters/<F>/path file
> 
> Introduces a new DAMON sysfs file to allow users to set the target memory
> cgroup for memory cgroup attribute monitoring. Users write the path of the
> memcg to this file.
> 
> > Introduce a new DAMON sysfs file for letting users setup the target
> > memory cgroup of the belonging memory cgroup attribute monitoring.  The
> > file is named 'filter', located under the probe filter directory.  Users
> > can set the target memory cgroup by writing the path to the memory
> > cgroup from the cgroup mount point to the file.
> 
> This isn't a bug, but the commit message states the file is named 'filter',
> while the subject line and the newly added code define the attribute as
> 'path'. Could the commit message be updated to more precisely match the
> actual sysfs file name?

Good finding!  I will fix.


Thanks,
SJ

[...]
