Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654901382
	for <damon@lists.linux.dev>; Tue, 12 Sep 2023 01:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDDDC433BA;
	Tue, 12 Sep 2023 01:56:31 +0000 (UTC)
Date: Mon, 11 Sep 2023 21:56:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911215648.2cdff894@gandalf.local.home>
In-Reply-To: <20230912014308.38298-1-sj@kernel.org>
References: <20230911165144.5002a0ac@gandalf.local.home>
	<20230912014308.38298-1-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Sep 2023 01:43:08 +0000
SeongJae Park <sj@kernel.org> wrote:

> Nevertheless, since the variable is unsigned int, I would need to use UINT_MAX
> instead.  To make the code easier to understand, I'd prefer to add a third
> parameter, as you suggested as another option at the original reply, like
> below:

That works too.

-- Steve
