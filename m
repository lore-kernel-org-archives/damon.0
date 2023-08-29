Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BF6AAC
	for <damon@lists.linux.dev>; Tue, 29 Aug 2023 23:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB135C433C8;
	Tue, 29 Aug 2023 23:16:31 +0000 (UTC)
Date: Tue, 29 Aug 2023 19:16:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230829191629.25c5f0e2@rorschach.local.home>
In-Reply-To: <20230827004045.49516-1-sj@kernel.org>
References: <20230827004045.49516-1-sj@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Aug 2023 00:40:45 +0000
SeongJae Park <sj@kernel.org> wrote:

> +	TP_STRUCT__entry(
> +		__field(unsigned int, context_idx)

4 bytes

> +		__field(unsigned int, scheme_idx)

4 bytes

> +		__field(unsigned long, target_idx)

8 bytes

> +		__field(unsigned int, nr_regions)

4 bytes

> +		__field(unsigned long, start)

This is going to cause a 4 byte hole. I would move nr_regions after end
so that it stays properly aligned.

-- Steve



> +		__field(unsigned long, end)
> +		__field(unsigned int, nr_accesses)
> +		__field(unsigned int, age)
> +	),
> +
