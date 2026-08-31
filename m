Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BC3DCD9B;
	Mon, 31 Aug 2026 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219081; cv=none; b=X5Eu05fY1L+fjrKU+XcEYAY9tt7coJZXQp/WbQSxtBXEFLAIQOtBBVOd80OQ+Yy1ZosR6mi5s8sZMU4hMTd5A8QVor/xELB1zjSlV4pjRF/JPa3vHvRKFrrwvi5xDOnSTY6CpGwOjgwr3NCNSWddSjmL2dj/qD95A2WUHGTjfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219081; c=relaxed/simple;
	bh=afVsImGUocGyybwn+/HgTgiCVncwqPFBjrVOSgHBm6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M33NPNwBKzme3MrUre4EhMaB5eM+XUpX0hkD3Iav+Tb4m/bzEYuS+PNXi0CACuYx/240u1dvw1nc3f1lOoxJpj2m+lvYK5WbgzrpDHRziimOyxzwYfDnlBqhBgqnz0Ref5Z2KuWPE8+pOfLN8q1cqCyCZfN8Xavjf2LP5auapHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zg07NLIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zg07NLIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD351F000E9;
	Mon, 31 Aug 2026 23:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788219080;
	bh=jizsFETCWcLjtbHiJF9W08hqM5CBVKybdf/GQ2X6ALI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zg07NLIHLvXKjITd2jS6CzCbIu0ABOpMuUX0qsGivAZ6HN5JAgik4Z7hYq3tAXt0L
	 luxyGGooi1iSkwnUYX4fwRzZqNpQ0zh8Ki4dpS5aixZ1hOeYohpKdX3zi68UYMN41b
	 xZJYEbqMSW5Ogq9nhfYJqjW0Ain6xsCNjQPhU1Io=
Date: Mon, 31 Aug 2026 16:31:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH 2/7] mm/damon/core: introduce damon_set_target_pid()
Message-Id: <20260831163119.66bcfdd8a4ee66b3609be63a@linux-foundation.org>
In-Reply-To: <20260831142611.77572-3-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
	<20260831142611.77572-3-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 07:26:04 -0700 SJ Park <sj@kernel.org> wrote:

> The logic that finds the struct pid for a given pid number and assigns
> it to a damon_target is duplicated in multiple places.  Including
> damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
> of the two sample modules, samples/damon/wsse.c and
> samples/damon/prcl.c.  Add a function that does the work, and replace
> the duplicated code in the places with calls to the function.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

I assumed that From:Enze was intended here.

