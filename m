Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA810F9;
	Thu, 13 Jun 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287667; cv=none; b=IpM2cqsJrArEEKeVbm8AV/df6yeg9itC/98rJrJBQqcTSA6xxFNGZeALNMG/uppsQhB+aB64ko/cUem2lyObJKzzgKVr8u1SQGP7KtA8nJmx/p/sjugdmK9KutKxGqqGElLsKVV5EZrsw2o2+lUp9/CPieRgleCfoNZ6bT9NGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287667; c=relaxed/simple;
	bh=odfp1TpgeErbFjJ61Se8vEzIbx/qU6+JD3DTGwxuJtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=t3e+5wnHk8mTrXx9c0c7TokYWPkWmd+C4PHjyFctTr/5KUxeBZoBWBPTu+Z0lh6IjA1WzKkEag1fAS+7u0/gBzcrnaYU4lPCLVGV/nzBhSd9Fn6lW0f3q7lWLFXxpnze9AfvWP00Cz60swQ6mIKf+5sBMxoJtTfsttJ+4TaI/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2Gh31x0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2Gh31x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830FEC2BBFC;
	Thu, 13 Jun 2024 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287667;
	bh=odfp1TpgeErbFjJ61Se8vEzIbx/qU6+JD3DTGwxuJtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=Q2Gh31x0D8g+FDWZnBJ4HAyMYMjVk7RRlq9uO/0AyrM13tWmr2HVLbcigsBbvVBBW
	 1VjNa589ejVuxOYtWXUj0IKD9Xfx977Gg8zRrx9cv7+bNbGExDAVOcpBQqpj4aJ+Z1
	 MD4HjSxYbfUSAttpDVRdLUHUO5KY0VY8WbYlm7pcoBYWQ4x8Ww+ztMuR/h/9i+wXxx
	 ZT86AZO+IFS2ELHnLt2kAqh/IdrAENiicumNSjxi7SdBL1qL9HX7i2Stlq1HD1uyAh
	 5frETOxA7lkrf/IZuHk13SkQwy6m8fRZiVJLZ5qn8sZIZAOwdeSpTQHuxUKItzKTDW
	 0rycJZY4fktsA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com
Subject: Re: [PATCH v5 8/8] Docs/.../mm/damon: add more damos actions
Date: Thu, 13 Jun 2024 07:07:29 -0700
Message-Id: <20240613140729.27177-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240613132056.608-9-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi Honggyu,

On Thu, 13 Jun 2024 22:20:55 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This patch adds damon description for "migrate_hot" and "migrate_cold"
> actions for both usage and design documents as long as a new
> "target_nid" knob to set the migration target node.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 8 +++++++-
>  Documentation/mm/damon/design.rst            | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index 7bff54963975..84d62d16c9f9 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -300,6 +300,10 @@ from the file and their meaning are same to those of the list on
>  The ``apply_interval_us`` file is for setting and getting the scheme's
>  :ref:`apply_interval <damon_design_damos>` in microseconds.
>  
> +The ``target_nid`` file is for setting the migration target node, which is
> +only meaningful when the ``action`` is either ``migrate_hot`` or
> +``migrate_cold``.
> +
>  .. _sysfs_access_pattern:
>  
>  schemes/<N>/access_pattern/
> @@ -759,7 +763,9 @@ list on :ref:`design doc <damon_design_damos_action>`.
>   - 4: ``nohugepage``
>   - 5: ``lru_prio``
>   - 6: ``lru_deprio``
> - - 7: ``stat``
> + - 7: ``migrate_hot``
> + - 8: ``migrate_cold``
> + - 9: ``stat``

This section is for DAMON debugfs interface.  And to my understanding, this
patchset is not adding support of migrate_{hot,cold} DAMOS actions on DAMON
debugfs interface.  So I think this part should be removed.

>  
>  Quota
>  ~~~~~
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 3df387249937..3f12c884eb3a 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -325,6 +325,10 @@ that supports each action are as below.
>     Supported by ``paddr`` operations set.
>   - ``lru_deprio``: Deprioritize the region on its LRU lists.
>     Supported by ``paddr`` operations set.
> + - ``migrate_hot``: Migrate the regions prioritizing warmer regions.
> +   Supported by ``paddr`` operations set.
> + - ``migrate_cold``: Migrate the regions prioritizing colder regions.
> +   Supported by ``paddr`` operations set.
>   - ``stat``: Do nothing but count the statistics.
>     Supported by all operations sets.

Except the DAMON debugfs interface section, this patch looks good to me.


Thanks,
SJ

[...]
