Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF026208CA
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037065; cv=none; b=NuK2bg+QbpFjR+mjABMJG2RqAae5VVG4iaDXJ7+Gzc1mVD4P7wTAjF2OomwJimlQy95uAPkjZfGqXWb4TTG1z17QSJWegOZxgshQqHysvlXX3u5aVO0hGc9buKLF9+isVO8xsWTRTR1JD3vhXx53pCdt6n7aGJDSVN6AIhVmgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037065; c=relaxed/simple;
	bh=miipKiTqF7JpECaUEluYI41x3HMUaCIGaCjb5/2xIkk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FLFF7W0PYzR6oBjr5/BoWijox7WJpGpeqPTf1wSuZKKWXcWdY09wP6oj1I6LHcyEkg66otEIjRddDcWyY9dDj2R32tIpLv527gNRWKWZx3GN7dIut8gXRzXOpEPFOnnKcVke7DDvxxevBzXbF+yzo7JvZs+aeo4ZleF/VpfmJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VZPhh9am; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VZPhh9am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38371C4CEF0;
	Tue, 12 Aug 2025 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755037064;
	bh=miipKiTqF7JpECaUEluYI41x3HMUaCIGaCjb5/2xIkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZPhh9amNgD6bU+DfrwnuclBnrQ/9RE3gflGp5IJCrnEth70N5IVPntS17Hhn6Kj9
	 j2fTn1iK+41SHXmIYhXgI9vs985Cl3cOMjSk3n+z8wk/nYjDNifiGJLC+H2OnL9lmc
	 nNW5TFGEtCbnJtyRn4QjdVzPyT0y1+wvZadAEzRA=
Date: Tue, 12 Aug 2025 15:17:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>, honggyu.kim@sk.com,
 damon@lists.linux.dev, linux-mm@kvack.org, Alexandre Ghiti
 <alexghiti@rivosinc.com>
Subject: Re: [PATCH] selftests/damon: fix selftests by installing drgn
 related script
Message-Id: <20250812151743.570bde54f31007cf986a2f52@linux-foundation.org>
In-Reply-To: <20250812175939.57506-1-sj@kernel.org>
References: <20250812140046.660486-1-ekffu200098@gmail.com>
	<20250812175939.57506-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 10:59:39 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 12 Aug 2025 23:00:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
> > drgn_dump_damon_status is not installed while kselftest setup.
> > It can breaks other tests which depend on drgn_dump_damon_status.
> > Install drgn_dump_damon_status files to fix broken test.
> 
> This patch conflicts with the similar one from Alexandre Ghiti.  Could you
> please rebase yours on top of Alexandre's one (and mention the dependency on
> the comment section under '---' line), unless Andrew resolves the conflict on
> his own?
> 
> > 
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

I'll add

Fixes: f3e8e1e51362 ("selftests/damon: add drgn script for extracting damon status")
