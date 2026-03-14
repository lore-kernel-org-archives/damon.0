Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8C26AF4;
	Sat, 14 Mar 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773528670; cv=none; b=fL7caRHmoo95Llmy4tf/phxtXP6MtRX9MZAid4ggVvhpciKizrWnZmgdVCDQar4JkiEhSvshisycfzfGYpOdabcVo/2htOmJngzeIIIouPwQ29u1sSm6EQtLjb6/iPfLoOjmWBCyPSs7OkdHdk/CCuVDA2zNtdessImDBB7f0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773528670; c=relaxed/simple;
	bh=4tWZx42twyBePr3J1Y66iQLkre3WZLhQ6Fbu5xC5H1g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hlJha0bdAeh6xpF44ZHq4FgBpI9Az4o3WKIiQphgmBd+DvxDaIymA3aezzTxx+D8sSe9J9lw6cIFnDlFRMFHs58dNYNls6WeNiuKUoyDnxHM0ZhlrACdEVZ+1RjLBWfIsukPv579MztjAwh+lFMYpiSV+qPLBee4mu9YL8dwJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bnWEn5WO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bnWEn5WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6493C116C6;
	Sat, 14 Mar 2026 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773528670;
	bh=4tWZx42twyBePr3J1Y66iQLkre3WZLhQ6Fbu5xC5H1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bnWEn5WOuzuASTldcQinAKJv2qKeCsF1UjrnpVs/M5Mj2nHIFZrLpNqzEGKSHzY7A
	 C0+KnnHzeZsUeyxyksEOj5UbRmf8FJL8qwxIH9pnsZ+1UdzxgvlSFJ00KsvvrDW+4I
	 H4yqjONSdUXIGTKm0xuRSrUWZC3NqxiNmx9E402c=
Date: Sat, 14 Mar 2026 15:51:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/stat: monitor all System RAM resources
Message-Id: <20260314155109.5e37efaea8ef72f169434d35@linux-foundation.org>
In-Reply-To: <20260313234026.48872-1-sj@kernel.org>
References: <20260313044449.4038-1-sj@kernel.org>
	<20260313234026.48872-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 16:40:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> FYI, I found this issue from an AI code review result [1] that published on the
> internet.  The review also added two more comments, but those seem irrelevant
> to me, so ignoring.  I don't know who made the web site.  I only got the url
> from a social.kernel.org post [2].  Whoever made the web site,

Sashiko is being led by Roman at Google.

> thanks for the review.

yop, it's good.

> 
> [1] https://sashiko.dev/#/patchset/20260313044449.4038-1-sj%40kernel.org
> [2] https://social.kernel.org/notice/B4E8DdeZY07PseemfI


