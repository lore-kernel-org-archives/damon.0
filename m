Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A5DF60
	for <damon@lists.linux.dev>; Wed,  1 Jan 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735753433; cv=none; b=FoaOBCgRqZsL4YVmHMxUGZMNYO6yQofDRrOAFIQkNVLRApw8/TzqL1odP1VkFLAsuv9h8S2N1ncCZv8nQdJYwzONfc/rQww3aYr8GMIVR801HvCAWc4QAMikm3kjpcs9U8E/t3s6oTuP3JtC7xb3/7mXIH4S61FqOXYe5k1MIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735753433; c=relaxed/simple;
	bh=V6e6pPYwiV1n8acz4TFe3Grn7Mlm/3TEqBLDO9tbDdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je0w4F6PR8JaAQ7mORUvxOZ8KRakzzNULTTrnJl85lQrd2JOVLYAqidSCCcO5d6yDzvEOCZjzgi6gB8xfg01Uay3GHrAh63GI9/DPZw8Kna7pG+GSAEBRmolrHOcKBKndHeXqyqllbd+F15Z6IdSCslFVMISwkC6JjgxqwMpkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zew5vGl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zew5vGl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3737EC4CECE;
	Wed,  1 Jan 2025 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735753432;
	bh=V6e6pPYwiV1n8acz4TFe3Grn7Mlm/3TEqBLDO9tbDdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zew5vGl/kLtjtOIe4BgI3ObGS37amDafj3nwCWkQd7BSDn815/eCIo1dibTLLXSvP
	 YI1Z6KQ3EvDENJVBEWDANSsMz+9gSRfed790Pc9Kl/bsV2nOcHi3Q7z8gqkV6xxGDf
	 rg5cxa+W794rVn3cnOvUSUlgjfVZ80PXQoKZvtES8ltmsDKg8AGaOxhB/TJNpX15+J
	 FcLmWzFgLoi/YXOgfTY2a5WboMfKpO8rM2HtILaa80FqiuoeRMGImDzdiYcynMgBkO
	 DAd5/GT9oixDig5A5NlZgcn3SfrSGPaWHFGpJ5ZPLJM3fIaes331Z8O+D/qqOxX66O
	 LIN8PDVAtW2fQ==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: trace: print address range in hex
Date: Wed,  1 Jan 2025 09:43:49 -0800
Message-Id: <20250101174349.71139-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAC5umyh9k_xvRws9HdmuF8op424VL8j50304+m=GsY+jfxADbQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 31 Dec 2024 21:56:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2024年12月31日(火) 3:39 SeongJae Park <sj@kernel.org>:
> >
> > On Mon, 30 Dec 2024 10:28:13 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > Hello Akinobu,
> > >
> > > On Mon, 30 Dec 2024 22:42:20 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > >
> > > > Currently, the address ranges are displayed in decimal format in
> > > > tracepoints for DAMON, but hexadecimal format is easier to compare with
> > > > address ranges in /proc/<pid>/numa_maps.
> > >
> > > I agree that it could be easier for the use case.  But, I think writing and
> > > using a script converting formats for DAMON tracepoint output or numa_maps
> > > could also be a way to resolve the issue.
> >
> > For example, we can extend 'damo' to optionally do the conversion.  Depending
> > on your use case (if you also use 'damo' for your use case), it might be a way
> > to move forward?
> 
> I'm currently using perf trace (-e damon:* --libtraceevent_print) to see which
> address range accesses were detected or not,

Thank you for kindly sharing your use case.  I'm not very sure why you need to
use 'perf trace' instead of 'damo', though.  'damo' supports recording the
whole events and getting access monitoring result snapshots in live, with a few
results filtering criterias.  I just assume you had to use 'perf trace' since
you want to read full events in realtime, but please let me know if you want to
know more details about 'damo' features that might help you.

> so as you suggested, I'll create a
> script to convert the output of the perf trace.

Thank you for accepting my suggestion.  Please let me know if there is anything
that I can help at writing the script.  For example, if you really need to use
'perf trace', we're open to extend 'damo' for that.


Thanks,
SJ
