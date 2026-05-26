Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5C22157B;
	Tue, 26 May 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805712; cv=none; b=l5FBH8go16gaqqw+/w/QqOAXDnFKJ5LmzvfJNOw8L56YuyBszYymQNFugcl0WRjOIoNvcMqYph7D2BSfzJDYh37z73Agbuqm10sdg6aXrD5JTADyc+uTRtCzx5DjWm0Uwb2p/itBC0xA1NjZk8xx3yeR0yih1vx4CVzVbFsUqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805712; c=relaxed/simple;
	bh=As8bHLBlLr01XyohdNTcNL5lP6Tbe8MGR2T+rJGJxBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4lhqQHAfMNjn/PdL4A71jkO96s5/jKfNoUoJTsZ573i8lKEpPxz8zb52tvSx6iQyAVXCA+Yl4hdM/xIbCMGcWSVe7vVJg/ho0V/VucvC1DkGY9JIsI/aim9VNtDvwnxcrkrJmiK4dHO//ZcUgo7ZL79GesiEqf4XTEaSroDDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ips0T11H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ips0T11H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8972B1F000E9;
	Tue, 26 May 2026 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805711;
	bh=p0nQZozQqAnFi1e8/sbfxl6VatcGv7ZR6h2AJpKUJlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ips0T11H1BEJLwMBDHQBYrBhG0vHQcQYOi8DygUZlC1CjfTAo9IfD91aAR8wsyZqD
	 K0YzcntjPOgS3tdnJrRH9rVOGKTQhPWw+XQnLozrcB+0wgWqzVpauqOOXU8MDDmZxn
	 UKaDtmYb/+1QRy75RsTlsZfI3kaWSx04T/oWXeIw6R7ozFQ17Dm6LgL5FXq7kVguqG
	 aK+KpQH5FTbIlOx0oO+vSogDcE3kzcwWhyJxxOkHrVrPPI1/fTFucfUe2LHFWRaUk/
	 pnocEuuvKSlCCQbofzkvU5afjYJ6clGvR4kbtdLf9NPaPL39a0sSTtK+1VDZ3QkTxw
	 5WY6UNO5IojBA==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	bharata@amd.com,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [RFC PATCH 0/7] mm/damon: hardware-sampled access reports + AMD IBS Op example
Date: Tue, 26 May 2026 07:28:25 -0700
Message-ID: <20260526142826.91341-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y167W9Cs0zFh6rnbDgk91cMvtofSxuAu_-M3dWwiSkbTKQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 25 May 2026 17:05:06 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Wed, May 20, 2026 at 5:32 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 20 May 2026 12:01:43 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > On Mon, May 18, 2026 at 11:19 PM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > + Akinobu
> > > >
> > > > Hello Ravi,
> > > >
> > > > On Sat, 16 May 2026 15:34:25 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
[...]
> > To my understanding, this RFC reuses the damon_report_access() infrastructure
> > that shared with the per-CPUs/threds/writes/reads monitoring series [1].  My
> > plan at the moment is to keep using it.  So from high level view, I think the
> > final picture would be not really different from this RFC.
> >
> 
> Hi SJ,
> 
>    Sorry for the delayed reply. Was away for a couple of days.

No worry!

> This resolves the layering question for me.

Glad to hear it helps!

[...]
> > I'm still not familiar with IBS and perf events.  Please bear in mind with me.
> > My understanding is that there are vendor-specific knobs for IBS that perf
> > event is not supporting.  So far, that makes sense.  And are you saying that
> > you have to write paddr_ibs as a loadable module if you want to support the
> > vendor-specific knobs?  If I'm understanding you correctly could you further
> > share why it cannot be done as a builtin module?
> >
> 
> This RFC's IBS backend does not claim exclusive use of IBS.
> 
> The reason patch 7 ships as tristate is precedent and reuse: Bharata's
> pghot v5 posted its IBS driver as a module, and I matched that shape
> during development so the two consumers could potentially share IBS
> plumbing instead of duplicating it.  Patches 1 and 2 exist to support
> loadable ops modules generally.

Got it, thank you for clarifying!


Thanks,
SJ

[...]
