Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238F351C1E;
	Fri, 16 Oct 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159275; cv=none; b=qDOF94UzVCx+Dszy/C52yr35a7uY+wYs8MLMTHN2OMe9fdzWO+3RjNn5phZ+ZNI9Foi9BYnbUhCLHKOAosSVkIYYQxFPY7iT05/GcOU1r+hgKVZkJ1AfRNu4CZxHM+8j/A9E3JBZuI0RaTcAOEkYFwo07GpHGp7X/xqOQKiYI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159275; c=relaxed/simple;
	bh=lpfrny3NCO4zE7HCxAsttofE/DItjDBT1tEsUekDJfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbEoO1DDX+q59IiQvDoiIMODTeTkcVQOAMGvxjblKe7g42FzRi/yYVDnbxX6CasXS+Dmz0+B3jSyaLlyU4BJEb9IZ6l6kRW2cgxwREcDZVRf95KlSqG7sRDgyngHNDlZyEG8Huq7NI8nIHJByJnNvEHvc9wy7y3BzMy2Moi0xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDL9W2ud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDL9W2ud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47001F000C4;
	Fri, 16 Oct 2026 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792159273;
	bh=pnjLVyf6myQJUuaqwlYmu6gwLwBU3rB08827vgARd+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDL9W2udIs5FpN86pee9VwvNSEcCwiRcEJhZjtShWYoXLWqigbOI3aCi+1gF6/39B
	 18Bq2/AqbZy6AYPsUmhAzCwOMrlqZNN2VnISfElelz8dVVvKo1DMwJooELZk8rYjIc
	 EOqdw6Y6kWcJA+Br/3AE+8v6urwSIHfV3CVi4Bl2a+XOjDXS4UHKuT2ossucN7Evbh
	 aqrMJf+xnwJlwpagI0CiK3dYX53QWU/mu91bHtwtEpvF9QgCfyUvVxxYydMUT8JSFy
	 ctrF7QokwqjJU/PGB05ORjgxEfU1+la6y2kgTph5GEXG+Rm2LZbXNQqohoT497XgvW
	 jU3GJM+z4V96w==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON sysfs: failed update clears tried_regions snapshot
Date: Fri, 16 Oct 2026 07:01:06 -0700
Message-ID: <20261016140106.118283-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmHMRh6Sa=6N=hM8VzO0HRaFL0FxQB7An8=Y-X5GX36kmg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 19:12:25 -0700 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> > Please do not "top-post" [1].
> 
> Sorry about that. I'll avoid top-posting from now on : (

No worry, nobody knows everything from the beginning, and we all learn from
mistakes.

> 
> > You shared 4 bug reports in very short time. Three of those are
> > from 32 bit.
> > Could you disclose the purpose of the testing and how you are
> > doing the testing, finding bugs, and reporting those?
> 
> I've been trying to understand DAMON in more depth with help from
> an LLM, not deliberately hunting for bugs. It spotted a few possible
> problems as we went through the code. After checking the code and
> reproducing them in QEMU, I thought they were worth reporting.

That makes sense, thank you for sharing the context.

> If that wasn't the right way to go about it, please let me know :)

That's the right way.  Nonetheless, disclosing this kind of information is very
helpful.  Particularly nowadays, use of AI-like tools is nearly always better
to disclose.  It is not because maintainers hate AI.  It is because AI-like
tools are still something new that sometimes good but also do mistake, and
therefore maintainers are still learning the tools.  I'd suggest disclosing
this kind of context in your future contexts, not only for DAMON, but for
kernel works in general.

> 
> > Why would the tool tries to refresh the regions after the monitoring
> > is stopped?
> 
> That's probably not something normal users would do. The test
> deliberately called the update after monitoring stopped and found
> that the failed request cleared the old snapshot. It looked
> unexpected, so I reported it to ask whether that's intended.

Makes sense.  So I think this is not DAMON implementation problem.  Tools
should aware this and do not try refreshing when the kdamond is terminated, or
remember old snapshot.

If this behavior is not documented, that's documentation issue that we shold
fix.  Please feel free to send a patch for documenting, if you don't mind.  If
DAMON user-space tool is not aware of this and give users unexpected results,
please feel free to send a PR for fixing it, if you don't mind.

> 
> > Is this an answer to my bisection question?
> 
> No, that wasn't a `git bisect` run. The suspect commit,
> `66178e4ec30a`, came from code review. I tested it and its
> parent `cce0b334c310` with the same setup. The parent kept
> the snapshot, but the newer commit cleared it.

Ok, that makes sense.  Thank you for letting me know this.  So, this is a
behavior that changed from that of the past.  But I still feel the current
behavior is not a real problem.  In a sense, if the kdamond is terminated, it
has no region and therefore showing no region makes sense to me.  Please let me
know if I'm missing something or you have other opinions.

> 
> Thx for your time, and sorry if I've caused any trouble:(

No worries.  I'm also sorry if you felt you are suspected or not welcomed.  I
believe now we are all good and you are welcomed.  Thank you for kindly
answering all my questions.


Thanks,
SJ

[...]
