Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F966511E66
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655174; cv=none; b=QItsboBOPgM8ysb0TBzE1RuE3GqWXEUJ7SYh6UC0FaV7OVriu+vaH1pDRYHTR6v0ZNI/FwvXWzApJ3RQh2DSy1Q8VrgCKzSIJr48r2dfWOuVIfsqmWa+oWWgR+kQBfT96q50aM/lqIFzn+/HRwRiLdmfYGZvvNOscf1Szu/phE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655174; c=relaxed/simple;
	bh=LsHVr3pAVvn5z8k0sF7Qnjz54hhKbEwpaapBmy84FQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=drJiCRkxmyrSTntTRxcKSWjURJg8SE8D7xzaUEDVMcEjwk5Yc6NVIRf4mhXfOUQgdL0mW9kbIBunFVT0r1HRMuZSfeBKHYEEE+eV8n21iPNzdOZtnUB3jhLxlfVoPSdjVhtSteroZEerczMzZyjb+gEj8Nc0jZUQd31KuzVuIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrQM0MxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrQM0MxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD731F000FF;
	Thu, 17 Sep 2026 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655173;
	bh=Jc902dxxgpqehwKawzjVF5YNJoZBpmolf63ZCUCIwGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrQM0MxPrOIgk1bIRgkFer3T6VGqKs7BOtTtuYdNML58492MbGp30h3XXqA1I3zgw
	 /erHpxlEposq6XnIiqByhRuE0Xa5fUv/w3Y2ARut/vBZEeIy5enBLjYrvdJCZmPDD1
	 vpEXuqnzPY0bVdZ+7TQBogyobf0RiOpgNh12zbt/gPaTxWrHnrg0WOsbs5MAA/MClt
	 W+fKW/odLwjWLJQTs6NHSbEiEqYCbB7/oTjtSBsMms6Xxwvww52loZH6A54WfguJ+z
	 4j+fxxt9WGkEEL+yz61qyV0HzL0mkIA1t9/9qPmVkPd51fjmwEKcRFEOc7tiG1gNwV
	 9yKjPbYiHTL2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] mm/damon/tests/core-kunit: test eligible_mem_bp
 commitment
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-8-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:26:12 +0000
Message-Id: <20260917142612.DFD731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> There was a DAMOS quota goal commit bug [1] that doesn't update the nid
> field for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric goal.  Add a kunit
> test case for confirming nid commitment.
>=20
> [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D7

