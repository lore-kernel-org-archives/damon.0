Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57613B293
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434050; cv=none; b=n6jBM7sGMpmnfjUhsoNi73xveEt3rP7q25zG98Ye+s1YQP8ZcenRbrCxytWU8WkaLJPnilfKSEEf0KJl81kfcZOaPHSacEDsIRpd43gkTBiXiZQfk1vA9uGoJI1O29uBMtKbNmDNrBP5MHGLc0jZ6IZ62XhAdde6PMV3rg1tgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434050; c=relaxed/simple;
	bh=2UGoRrCszIMnft2PYHQfiX/AiyEkkloVzKlanzPQ1hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz+AIvP1iSmIxEm5puHhAj+rnQW7jCN895uU/8GEg09qHDAtfTKkufVkoCBBDuXNkQ5xdwOocr+jF8u6DFPiGpxrQ9+Esx4ly8x5GjL777SKnk5pCiK+w8vLnj6apcftUD0zYQx5QTaD29uguhFUXHAFOUaq8zkpHrA25i8RMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEBgmSWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEBgmSWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E9A1F000E9;
	Fri, 26 Jun 2026 00:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782434048;
	bh=uPLb5vzxlm6UpzMyEI5m9HmO5RYsEXcIdk+uTaMKPjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEBgmSWSuxBIK1f7TuqcA7W8PSSqQURtml/MC46X8pV/urSzxv39fQVNi5tFyyrVl
	 4mJKI0Lrl7VtOH1RpAz9bHb2zg+fC25WppWGyZg6VVHHsKD5NOfnXTiZErIzxGJ+rO
	 9eeabJLr4cNt37jRPFc5d4Cb7kwcGeTYU1XW11E/CKWn1zoV+EA/xSH8oAhl8AYt5u
	 L2itOu/C+L2XuG5NYMlHeOddErGE820IXBsvEIt+FhcwlXbsz5QcQgkVZKAE4AKQjx
	 vdRHP+wetbD/JONOrzCLVjKRYjAPhCNkCWSB3SQO+8PHvfhk5fuMTzrrTw7S/1y3Cn
	 5oqewlX5XBYQw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 02/11] Docs/ABI/damon: document probe files
Date: Thu, 25 Jun 2026 17:34:02 -0700
Message-ID: <20260626003403.87662-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626002545.8211E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 00:25:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The documentation for the probe filter 'type' attribute fails to enumerate the supported filter type values.
> --
> 
> commit bda36c29fa892137debaa25d64442f7c3b5efd22
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/ABI/damon: document probe files
> 
> This commit updates the DAMON ABI document to include descriptions for the
> DAMON probe sysfs files.
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > index b73e6bc28ea5f..f914aab79fced 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> [ ... ]
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/type
> > +Date:		May 2026
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Writing to and reading from this file sets and gets the type of
> > +		the memory of the interest.
> 
> [Severity: Low]
> Does this documentation need to enumerate the supported filter type values
> (such as anon and memcg)?
> 
> Users reading the ABI documentation might not know what strings are valid to
> write into the probe filter type file without this information.

The beginning of the doc recommend users to refer to DAMON usage doc for more
details.  And there should be the list of the values, so let's not duplicate.

I would revisit this if a human user complains.


Thanks,
SJ

[...]
