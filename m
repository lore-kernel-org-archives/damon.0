Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD578381AF
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092497; cv=none; b=aoW22GcGyQafrvjDcPwXV8/oO5RrwP2HPTRKaE9fIl3jmyhZgPHjfEuiyQw/Hbi4UNHVXCkP4ZDPL8KKpDDHFYWhJaya1yebZkABnVEJDFXJGTjjupl3yySosN+wDtdmSR9pvD2RwL9nYZYxWnrxz7Pf4aaOyNuwsKTRMSRH4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092497; c=relaxed/simple;
	bh=Eiy7aCZMkT6WHB4JT4yqV1leiTSoT1rNEHvhKWAvP6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/4+b8ns9f6zIs5BMTWr5VY/rI+KG/0IQOTJaozHZXZmjT5zLVpGCPE7D4/O4KIo8FIKrfuVcKge7oh9cNJVrmYCvGrIphHkq8nc/QBIrgr9osI0LJs4HgShClQCFS4+4WdGhE9dmKAMXx/uD5QOoKSGIdoZXUxHspdEAQ499gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTq9Gn+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTq9Gn+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7F1F000E9;
	Sun, 26 Jul 2026 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092496;
	bh=f8+qVwDy7hJVKQ+d5daFe4OjgUDthxfG05Z9uOS5J2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTq9Gn+ujKKRCOLiIvWO3YGftvoB8+Ptm5hU/FfircEXBTx9eeoJy2WETcdO8B2kO
	 OGlMFLBfRbU/oj5xVo5fLvp+2MyDthwvfOEk09lfzrB8dcRbbuHSTuaBO6fHPCVBsn
	 rZdmWTaHTvuAXa9Mhr5WWAXtnWcO9z6KoUVCSsIz6gP7Ohj88r1vKT9LqyjEyXuQLk
	 8B8ZFNtVGRT1VWqYSQtOVxCNJ9on9gTjI/EJLofeKl//O6+9DVK9GTvIQXGtb0TSao
	 VX6WW7SaAeTxfvcvS7Fck4bD3ILUAC5YWmIhxweVf7NFhfRBxvhEgXe3rEqUeWef8l
	 EemuuHDTl5Wpg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Sun, 26 Jul 2026 12:01:28 -0700
Message-ID: <20260726190129.3342-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726174547.399DC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:45:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The sysfs path for the `prep_action` file is documented incorrectly as `prep/<R>/prep_action` instead of `preps/<R>/prep_action`.
> --
> 
> --- Patch [17]: [RFC PATCH v2 17/17] Docs/ABI/damon: document probe prep sysfs files ---
> commit c668115a6c46349a2601c78b7bdb1229021f721a
> Author: SJ Park <sj@kernel.org>
> 
> Docs/ABI/damon: document probe prep sysfs files
> 
> This commit updates the DAMON ABI documentation to include the newly added 
> DAMON probe prep sysfs files.
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > index e675a57145e36..f913f4eee4b4d 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> [ ... ]
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/nr_preps
> > +Date:		Jun 2026
> > +Contact:	SJ Park <sj@kernel.org>
> > +Description:	Writing a number 'N' to this file creates the number of
> > +		directories for each DAMON probing preparation action named '0'
> > +		to 'N-1' under the preps/ directory.
> > +
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/prep/<R>/prep_action
> 
> [Severity: Low]
> Is this path missing an 's'? 
> 
> The description above states the directories are created under the preps/
> directory, but this sysfs path uses prep/ instead of preps/. Should this
> be documented as preps/<R>/prep_action to match the actual sysfs directory
> name?

Good catch.  Will fix.

> 
> > +Date:		Jun 2026
> > +Contact:	SJ Park <sj@kernel.org>
> > +Description:	Writing to and reading from this file sets and gets the probing
> > +		preparation action.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=17


Thanks,
SJ
