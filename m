Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDC23DE;
	Tue,  8 Jul 2025 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995976; cv=none; b=pq/KB5hYJ95EWYro1514MxKeGx+JDlilxt8x9ko2jCW99wOThDIVND0iMtlXH1u7V9FnIenKGBkTquVir9LOvKdwy7VjjQweFHquusUOMewQEcvrwk9MwyxOjsvPNFQHsLUk0sA4wjnAPKpS3by7b+ipefcfW/SzBsuuNz5sO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995976; c=relaxed/simple;
	bh=Tj30AVgOZeLyHZLoCU9zwuYJtDxwx0/hpeoIjbFkhOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npYsF2EIIDNAMRd/AdC0RPywWKHZc9fz3Q7btXhOnRisZiPcgdZoTFlhic0KMEhu1VLMZHKzU1kveXqQ78KVKoEXGBdSSLrpQio0/9zG33AhlPZMFJvGp/Bp2KJF69pGRWxg4njluQqLNzdsoppcCFeoxlIAGEiLbaWOl/SRi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwdjdZ5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwdjdZ5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D81C4CEED;
	Tue,  8 Jul 2025 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751995976;
	bh=Tj30AVgOZeLyHZLoCU9zwuYJtDxwx0/hpeoIjbFkhOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwdjdZ5hSUdg4Xp5SziCZU45+i/ZBxR3cN7skTWzxY9ZFI/mBX/gdw618OkLEcwp+
	 e1pzEaUfXBhYMdL9KAQUfFK1HTeKmwg2pmQ65lh68LKSDXC0BCywVzpODJhQYeiPcG
	 bTWrA6zRJFVmwURla2p8tTRjlKSbOQPdGVFiEHlKkFBv5J0MFEau/Vtc772pOGysRQ
	 JjCkLowuyBbjim2cmBfZpYOp3w6Fe3ow5MqtCD6b97HEoZsIC1RdcpIYqON7pPYJMf
	 jGwEkwJJQ8M7948fmvrCQmaBHU0XDBblhqwInuGBkAKuEutcOFQzT5TPOjObK8iBpi
	 COAjsGtQrT7lA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v3 07/13] mm/damon/core: Commit damos->target_nid/migrate_dests
Date: Tue,  8 Jul 2025 10:32:53 -0700
Message-Id: <20250708173253.54732-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS6imiPU-v527rCu=Yw6JA1Nc-Ezkc5_uXOSxf8oDjX2Qg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bijan,

On Tue, 8 Jul 2025 09:04:02 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Wed, Jul 2, 2025 at 4:03 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed,  2 Jul 2025 15:13:30 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > From: Bijan Tabatabai <bijantabatab@micron.com>
> > >
> > > When committing new scheme parameters from the sysfs, copy the
> > > target_nid and migrate_dests of the source schemes into the destination
> > > schemes.
> >
> > Fixing the missed update of target_nid deserves Fixes: and Cc: stable@ in my
> > opinion.  Could you please split and post the part as another patch?  For the
> > Fixes, I think 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()") should
> > be appripriate.
> 
> Hi SJ,
> 
> To clarify, would you prefer it to be a seperate patch within the next
> version of this patchset? Or would you prefer it to be sent separately
> from the next version of the patchset?

I'd prefer latter (separate one).

Sorry for making the point ambiguous, and giving me this chance to clarify :)


Thanks,
SJ

[...]
