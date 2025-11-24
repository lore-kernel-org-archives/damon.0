Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF81B425C;
	Mon, 24 Nov 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998674; cv=none; b=lCmSPTdMO6Zec/4pwqBScHeYo5dXWOoykv8iSQCQ7bbY2tOB0zbwbGTv3hzkITWH+4RhFGRCSA56tP+H3nJSvp94DfVZgW4Y13nKox9MbC0Yi8cxgmisvPgtZi4HtxktpRh+tYv/UEfdur/6NaPPh/8zX3ZxVHbASg3WJgG6Haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998674; c=relaxed/simple;
	bh=hfU9q5a5jY4q1RimA224UIWPe1crK121VIC+KWwOW78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKvhClhbpKxOpD4Z/ctU3PRMZPzOI4VMjZ4Zw/8kmbKyvXKJ9h0M570ojAppCfCntXMcS4PaW9SnPm7GmUqHeUrXMbTiTcyk5AA1DIpXLrPWSkzD+fm/e1KXq7ciGktmzzPocNbvMpebn6yEXCs+3LIDO9AnFYwk6Y5Rbf8nHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA8jmYYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA8jmYYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C17AC4CEF1;
	Mon, 24 Nov 2025 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763998674;
	bh=hfU9q5a5jY4q1RimA224UIWPe1crK121VIC+KWwOW78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nA8jmYYSKp1h5nrFWDUH0fv9L4HlVdktdC2eOAgJOhsevXdNAA0dRnKOEjKGCSFxu
	 zkVqLXNWWfzIjnxmeqDP69ZCnOeAZrVUP21Z7swBQGQ/Egz1wT7Lcf2pVb8j2O+pm1
	 MpDik2ESFCtQdGU2mPhPyNdeXBhgkA1FQNJ1juzK2K37DIe3vgHlvef+Rstd+Eh3C8
	 BAKw9tACy76A9y9Nvf8sfsv9KypjyPkNktiuknQU/wXWtENDdB/xKQJWdIl8S1OJkU
	 UFiPRP+BgyfejHwiljtQ8r1s0Sdsmy2V9DWGYWzfzNoftt6O2vLKA4yzSBKxQnaoDn
	 fph8bfpOt2UVA==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 12/12] mm/damon/core: add trace point for damos stat per apply interval
Date: Mon, 24 Nov 2025 07:37:49 -0800
Message-ID: <20251124153750.73833-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124101545.0250445c@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 24 Nov 2025 10:15:45 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 23 Nov 2025 10:43:26 -0800
> SeongJae Park <sj@kernel.org> wrote:
> 
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
[...]
> I wonder if the above would look better (and still produce good assembly)
> if it was:
[...]
> I have no real preference. I just think keeping the "if ()" statement out
> of the main code as a more aesthetic look. But the above should be
> equivalent in actual functionality.

Thank you for this suggestion, Steve!  I'll update this patch as you suggested
in the next version.


Thanks,
SJ

[...]
