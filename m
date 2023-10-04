Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD4182;
	Wed,  4 Oct 2023 00:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2980AC433C8;
	Wed,  4 Oct 2023 00:49:17 +0000 (UTC)
Date: Tue, 3 Oct 2023 20:50:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] mm/damon/core: add a tracepoint for damos
 apply target regions
Message-ID: <20231003205022.58ffcb2a@gandalf.local.home>
In-Reply-To: <20230913022050.2109-2-sj@kernel.org>
References: <20230913022050.2109-1-sj@kernel.org>
	<20230913022050.2109-2-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2023 02:20:49 +0000
SeongJae Park <sj@kernel.org> wrote:

> DAMON provides damon_aggregated tracepoint, which exposes details of
> each region and its access monitoring results.  It is useful for
> getting whole monitoring results, e.g., for recording purposes.
>=20
> For investigations of DAMOS, DAMON Sysfs interface provides DAMOS
> statistics and tried_regions directory.  But, those provides only
> statistics and snapshots.  If the scheme is frequently applied and if
> the user needs to know every detail of DAMOS behavior, the
> snapshot-based interface could be insufficient and expensive.
>=20
> As a last resort, userspace users need to record the all monitoring
> results via damon_aggregated tracepoint and simulate how DAMOS would
> worked.  It is unnecessarily complicated.  DAMON kernel API users,
> meanwhile, can do that easily via before_damos_apply() callback field of
> 'struct damon_callback', though.
>=20
> Add a tracepoint that will be called just after before_damos_apply()
> callback for more convenient investigations of DAMOS.  The tracepoint
> exposes all details about each regions, similar to damon_aggregated
> tracepoint.
>=20
> Please note that DAMOS is currently not only for memory management but
> also for query-like efficient monitoring results retrievals (when 'stat'
> action is used).  Until now, only statistics or snapshots were
> supported.  Addition of this tracepoint allows efficient full recording
> of DAMOS-based filtered monitoring results.
>=20

=46rom a tracing point of view.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
