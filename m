Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F283672A9;
	Tue, 23 Jun 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222601; cv=none; b=WtZ9UTpevTzXyyXMDRAMlJNh3kRtM1MMPndnjRzQkh3/rkytMaL9dTMkcWa6wzRtWWZrgX0i0edrSHAvU4hlIj/t4HfPwDRlYCJ7eePJtND8Ea/yJ+NEE5xK74FkwZ4HjzHfql3tCo1lW+FXjJDb+djaPJ5UASrkoHUaab3hpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222601; c=relaxed/simple;
	bh=OWFLwEHF7W9lputR1v2T2W2OYXOGsNExq6BlSA6t8Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQuxXgwoF2rHjKoHhTCjoPWzt1+CS6Nl9SU2wteZKF7H0XQslK09lrhZs8PKA2P3xqIPHZZYKBqAI84wwX6m1kwnvkm38aR3q9BXnAmyhXX3McPU78E15Gypbi1RqLDQt4z0kKbaaY/tvJSxjmFZis+KyTgxK/nXPiB+jtu7NQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5IHRXcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5IHRXcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437191F000E9;
	Tue, 23 Jun 2026 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782222600;
	bh=svyr2jI1jKjjr0RRdllHjAlqzOB8wjEfxZ0aKCZy43U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5IHRXcIqOBEMtQkm2OsGHPGSy3XgB8kTa5A2eA+u5oBbztR9Ezzpp04RjGcWnHeO
	 UNBCxrNjjYh1WZ77tEJ48CN5BrCAyhKd+ZItJcdgKPX2zT1qprPlGwAe1vAJ8mdH0w
	 Pq0XiT3yHmLHP97XFzTnGAiDL5jJQAXO4pKqFldxLw8RhEotLPHWepyG1cEbKfTMDX
	 SoKdTdl5v3dEhXUj7z896yKq+ybz+5X4ZsfMJluQ82t1ftu2BtRl47IxSI99LbNPQG
	 d59nb8Px5ynyvdjAEoxskVN0j7erBcOrqXrAdQS2jddfvDZF3vfn3hgOQtvnsaqS2J
	 aKFoAoAIunoUA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	ravis.opensrc@gmail.com
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
Date: Tue, 23 Jun 2026 06:49:49 -0700
Message-ID: <20260623134951.67000-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyi0v8Z3Frtr4yL_LRZu9O7wWF1HZfVbutagORde_i-7XQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 23 Jun 2026 22:29:42 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年6月23日(火) 0:24 SeongJae Park <sj@kernel.org>:
> >
> > Hello Akinobu,
> >
> > On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > This patch set aims to make it easier to specify the perf event settings
> > > proposed for DAMON by Ravi's hardware-sampled access reports patch set [1]
> > > from the damo tool.
> >
> > Seems this patch is built on top of the per-CPU/thread/read/write monitoring
> > patch series [1].  We made a plan [2] to use another user interface, though.
> > The plan is, making the interface ready for page table accessed bits based
> > monitoring by LPC'26 (milestone 1), and implementing the perf event based
> > monitoring on top of it, by LSFMMBPF'27 (milestone 2).
> >
> > So the eventual damo part change for supporting perf event based monitoring
> > will be quite different from this series.  I guess you are sharing this series
> > not because you aiming to merge it as is right now, but just for sharing the
> > code with other stakeholders like Ravis, not me?  If I'm not wrong, I will skip
> > this series for now, to focus on the milestone 1.
> 
> Since I will align with the final user interface later, please focus on
> the optimal interface for Milestone 1 without worrying about that.

Thank you, Akinobu.

> 
> > Please let me know if you want more of my feedback.
> 
> However, even if the interface ends up being completely different from the
> current one, I believe that enabling configuration via `damo` using
> symbolic event names like this would still require calling the perf
> python interface (`import perf`) from damo and modifying the `perf` tool
> itself; could you please check if that approach is acceptable?

I'm bit concerned at having such dependencies.  I'd prefer making DAMON sysfs
interface uses a symbolic names and just use it from damo if possible.  If that
is not possible, could you share more details about why such changes are
required?  I'm still lazily delaying studying about perf events, so please bear
in mind with me.

> 
> Thank you for your continued excellent work on improving DAMON.

Thank you for your grateful contributions, too!


Thanks,
SJ

[...]
