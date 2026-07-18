Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D853E00B9
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784390424; cv=none; b=ob1lDknjJvIOYgyd1p1Aj02Ghvt86cj1xbWGSgZkJQnF67sPjT/NhDB+SB7y8Ku370NPEwZxKHWXXhxuuYc/uWs9d3Js1ofAMr+b60jyhbjlhFlNQoWbRvFUXgSGEweXJU6erGDstAler2IQL1zX5/TnJO39jDJ2ylzNRtb4MAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784390424; c=relaxed/simple;
	bh=lz3ab7g4+R7hCKEazIYyG9IFDX8MWzeDxJyCcmHnx5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mh9zB7XLcIKwxAibnPi/DK8SETE5qer4GawNt+3QwfSl4E7yyDH3bL/0E8iMHT7rS86X3zQW6523EqsXz8AkfR/Txa/e/TjXijuPaH56cs7qoClxLnHl86kl/4SDOwDEoz8Rf+R3V/Sur9mNhmu3euPK+MNxGUR6psOeLy7xdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/VTN4El; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/VTN4El"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8A81F000E9;
	Sat, 18 Jul 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784390407;
	bh=vfkxqiKdYwzHG3fHg7M/8qnUWMvkhDel8wVqh+LIVLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/VTN4ElaqZJJ1LUKJJZMTcMvE9QLRZJXqBbYHMMt33mj00hCpZnM1dVrPEtAhwnq
	 z71OeKFY4d1lB9UpLYvpSL0IsTdwDY4a/yXdO5CnbME98bDd2P/5L9LDwYDWM3xI1s
	 YK+Fna6HneQP/tFh50pXQWkMwNw1bWmDkk8Z98cfqPSsCeMYEA4Dg2DZch+K95sMBR
	 ANKuBiJcAPu9om/w0qa+xl+e4DHQ+ACyfOsMp19uxXJjN4r735+gevfxyaogF+bF6V
	 h8KDJ/4DY7Ia3tR9i/IYyf4z++S26aGERzSNUb6DEOCv8iI7KUm9s+zLsw5fyDQrXQ
	 Gb/576/VHkhLQ==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Question on damon_sysfs_memcg_path_to_id() path resolution
Date: Sat, 18 Jul 2026 08:59:51 -0700
Message-ID: <20260718155952.26350-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <04cc010d-5b8c-486d-b4d4-59cbe6dcab8b@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 16:40:51 +0800 Song Hu <husong@kylinos.cn> wrote:

> Hi,
> 
> Sorry for the late reply.

No worry!

[...]
> > I find the current behavior might be tedious if the user runs DAMON inside
> > cgroups.  Finding the absolute cgroup path inside containers might be
> > challenging.  If that's the case, I'm up to change or extend the behaviors.
> >
> > If this is only for making the code easier to maintain, I don't really feel
> > like it deserves the behavioral changes, to be honest.
> I looked into the container case more carefully and I'm no longer sure
> it justifies the change.
> 
> DAMON sysfs is root-only (state is 0600 under /sys/kernel/mm/damon), so
> whoever configures a scheme is effectively a host-level operator.  That
> operator can obtain the absolute cgroup path directly (e.g. from
> /proc/<pid>/cgroup), and the usage docs already show host-absolute
> paths.  A process able to write host DAMON sysfs from inside a non-init
> cgroup namespace is a privileged host-admin case, not really a "DAMON
> inside a container" user.  So I think the namespace-relative benefit is
> marginal at best.
> 
> Given that, and your point that maintainability alone isn't worth a
> behavioral change, I'll leave damon_sysfs_memcg_path_to_id() as-is.

Makes sense.

> 
> Thanks for thinking it through with me -- and for the cgroup_get_from_path pointer.

You're welcome.  I liked this dicsussion.  Looking forward to the next one!


Thanks,
SJ

[...]
