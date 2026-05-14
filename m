Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EA3290B8;
	Thu, 14 May 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724502; cv=none; b=VTTgGkAtIPac7mcErG/MT6v16m/DRgnXSplo7oIvUEu2PBQ1l18LgG1J8C2XT/T9KgoE9zGCPQIETsoH0PID+PPls+stV+uSI3zny9+zLyDh41Eu0Br4hen+/hsZUwCSEgcFlNyDxjZWlxwwBE114co0UBQPaWuHMUQggdy9Zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724502; c=relaxed/simple;
	bh=xmsxTv55KQCamp+BbcWIA7dTWkfwnz+fL+Tk5BOdaf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiAi0gxzS4k24ZBFuDvevstaHRde5nXDQ6t01j1Zv7YorRtp0CViRdSUqVwEK30JqqgRNVJJbSC9wjkeqn1ig2Ry/80X4ZVJlc7g2sWWh974sMvay8VCKS2ZblG3KJVD4cjU8qbGdXlHke79QHp71xAoLW592Yqlu93LWLvQJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcDHKgws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcDHKgws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6756CC2BCF5;
	Thu, 14 May 2026 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724501;
	bh=xmsxTv55KQCamp+BbcWIA7dTWkfwnz+fL+Tk5BOdaf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcDHKgwsR1xJpgn6fXlYuN1JaRr1dqzEPzp15c05Qa+I67e8SEcomezzpwOTaEdeK
	 R2fftdQcfxVkwmRpsWyitS9WSl+yUtyD9lnf8JEzxy5yutIfz5c2ANYGiK4P07/rhW
	 /owETnOBEu3Zyi1bt9koLxaoMFzlWegzl1mCNV/Fv4hXV6zZzkCGXwewmnw5FxqBGy
	 kpsctY9kMQQi1CznF0KT5vlqXn00U8AZs8airKAYCHUUO5u0ebtFZtjhxvJTgtia8d
	 5kibv9JKQZB+wnkuhdoeeeFBcgLDqest5Tl3/5cjpGg2m9sa9g/t6SrY8FHl/sxY9D
	 Pc15ec/H4mbrA==
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
Subject: Re: [RFC PATCH v2 18/28] mm/damon: trace probe_hits
Date: Wed, 13 May 2026 19:08:12 -0700
Message-ID: <20260514020812.149894-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513203237.3b1b3286@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 20:32:37 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 May 2026 17:06:10 -0700
> SeongJae Park <sj@kernel.org> wrote:
> 
> > Btw, if you don't mind, may I ask your opinion about the name having '_v2'
> > suffix?  I chose that as an RFC phase temporal name that doesn't break the
> > compatibility, planning to give it a better name later.  But I start feeling
> > just extending the original one might be another option because tracepoints are
> > not strict stable ABI to my understanding, and the change of the TP_prink
> > format should be simple enough (append the probe_hits= part) that the user
> > space could reasonably deal with.
> 
> It's only a stable ABI if some useful userspace tooling depends on it.
> Otherwise, feel free to change.

Makes perfect sense, thank you Steven!

> 
> Nothing really should be parsing the TP_printk() format part as it is
> really inefficient to do so. That's why I created libtraceevent and
> libtracefs to do the parsing of the raw data for you.

I will try to make DAMON user-space tool directly uses those.  At the moment,
it is lazily parsing trace-cmd or perf outputs.


Thanks,
SJ

[...]
