Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603532D8364
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017372; cv=none; b=j0IlGeQ5kMwRF+k6/u5TZryC9PyCH7KGkUJQnHXc7pEhQCOScsajmHUUdNWyEgV7cRNnHf2bAHcQzeHoq/diPnVnRNtTHmE/5tg3IsIcJb0dLaWDSjQiUpr7zA4X3vzC6MVbzah5I1uEppiZytTck99W8egiqOlRCEwitaysnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017372; c=relaxed/simple;
	bh=fabcab7jQklzBPLbnTH2smBOOL2pz6VvQHIztpo5ETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u62Eyn+evMz+viIYCkHyyMNwGPnZvFr0BJcuKPYEb5+9x6IPMlseJf9/CN4PLpD4nlDw0BsSerEBwioKZ3LwxFvVM6yXle5pbU9eLvrU3K5uLdWkxt+YB7Mmthqj1WcPuZdVp5kyIMGV2yF+7vbA86gv1s54p6w0DcYv9TG9xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1or6Z/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1or6Z/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1131F000E9;
	Sat, 25 Jul 2026 22:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785017371;
	bh=5BWRPWPp4DctJhWAlGksWaJSW7CdR22It3/3Cl4m1fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1or6Z/x8H8U6pqrjEDEYEcS5aPUKvJ1FGInKOJHH8IdbYZC4+117zfoGECyVMe46
	 aflfAKc02n7I/R6V7UUtKJTEBkNq43UZ4F51vdRuyW2HGpYgPMU+sCdJatJCYDctYG
	 aLduLoUpq1cwXXL+DCLBsk93b3uyXqHvGgjqMjpmuOzrIz2KypLZ5US7bkGt6MIGxF
	 q/OPe6L3ZxARUg/OHQREDzQd/wm8/D2rAGood3+WpI8ovkJ0g+KYObKprVSAA+9kFs
	 Jsb/WgtfmEFG+yFHbEdMSlyKGfWt+WZWD0q1ANA97MrpR1z6Vwb9+qDPbZFnBIrAl4
	 wiFyh2j/AVfCw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Sat, 25 Jul 2026 15:09:22 -0700
Message-ID: <20260725220924.137362-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211248.098301F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:12:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The documented sysfs ABI path and filename for DAMON probe preparation actions do not match the actual kernel implementation, and the description contains a typographical error.
> --
> 
> --- Patch [17]: [RFC PATCH 17/17] Docs/ABI/damon: document probe prep sysfs files ---
> commit cfe472afe661c1a2901b08aa9b4dfa86ac237ee5
> Author: SJ Park <sj@kernel.org>
> 
> Docs/ABI/damon: document probe prep sysfs files
> 
> This commit updates the DAMON ABI document for the newly added DAMON probe 
> prep sysfs files.
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > index e675a57145e36..6d596fb7fa1ff 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> [ ... ]
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/prep/<R>/action
> > +Date:		Jun 2026
> > +Contact:	SJ Park <sj@kernel.org>
> > +Description:	Writing to and reading from this file sets and gets the probing
> > +		preeparation action.
> 
> [Severity: Low]
> Does this documented path match the actual sysfs implementation?
> 
> Looking at damon_sysfs_prep_prep_action_attr in mm/damon/sysfs.c, the 
> attribute file appears to be created as prep_action instead of action, and it
> resides under the preps/ directory instead of prep/. Should the documented 
> path be updated to preps/<R>/prep_action to align with the kernel code?
> 
> This isn't a bug, but there is a typo in the word preeparation.

Nice catches.  I will fix.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=17


Thanks,
SJ
