Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF473AFD01;
	Tue, 19 May 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203329; cv=none; b=ZO1+kRMIEnUFYXZ1+vdVFgdprs5aS2DcMy+YNfAfJPOltfzrhZUdZP+oeGCsWuTqL3YJhEuHruERYYs13u60UcVSRQhDA8keKpnWtA+fVluEZWdBytS0pLoVe6WBNurJTu8z99kb4b2423vv5wpfHJ7y6XxNpQm60mzR9FcqEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203329; c=relaxed/simple;
	bh=FV3bnHAWG6JDwG0vOhj0R9ovh5EwMNT07xgca6IrsjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgvbbqVuBvciRGTXNhUJ8o8ozeI1kGPfdXHMy6RD5zAaFqP8NdG6989a/XULJ9e3Oy2PLE3B7dcQYZ7AMzp0RTWRvY2Jd6yF2jb09gxxgBHsVyk9FGOB6f8Ai94qATun4UUYX6W+pAS2GE4Ustt9gQESZGMfmvTowr3gDcL3hwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxFFM0MU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxFFM0MU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C42C2BCB3;
	Tue, 19 May 2026 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203329;
	bh=FV3bnHAWG6JDwG0vOhj0R9ovh5EwMNT07xgca6IrsjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxFFM0MUdtG1/OomlH1wMHjesjiBoIXpggoVovV6Q2YPLfYRV7l/whvmgtymdZ38S
	 GL9JouK6vRu6x7woFSDvJUCPSS+FdkAFnRKZaGZ3PdcYHoWRzYCwIfM/X8DIoyFB4j
	 mi2ZrlnIX2WKexq9YtYTIC2l9RBEekmXzkMXLQVLT4j+gx/Eyfn39xsZhTcoVE8gwe
	 VM7qrlaDqPKuyKXB7U4fvB54AuqXNLgcAP/ghlyAXH/JA9Nei7uRREUwoWB/dSqTBs
	 vSAxLPbI3GfB+L14zWH/kLR888VQCgrrFHQs8G5CGQnSEWjqDDW3BREPyLQ6qexZ6E
	 sNRPwsL5eUy7w==
From: SeongJae Park <sj@kernel.org>
To: Maksym Shcherba <mshcherba2000@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/damon/sysfs: implement update_schemes_quota_goals command
Date: Tue, 19 May 2026 08:08:21 -0700
Message-ID: <20260519150822.92326-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519073352.16587-1-maksym.shcherba@lnu.edu.ua>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 May 2026 10:33:52 +0300 Maksym Shcherba <mshcherba2000@gmail.com> wrote:

> On Mon, 18 May 2026 17:17:02 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 18 May 2026 22:09:28 +0300 Maksym Shcherba <mshcherba2000@gmail.com> wrote:
> > 
> > > Add the logic to copy the current_value from the internal
> > > damos_quota_goal structure to the damos_sysfs_quota_goal sysfs structure.
> > > Introduce the DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS command
> > > and integrate it with the sysfs interface via the 'state' file.
> > 
> > Could you please further elaborate why you think this change is needed?  What
> > is the expected use case and benefit?
> >
> 
> Hi SJ,
> 
> The documentation (`Documentation/admin-guide/mm/damon/usage.rst`)
> states that users can read the `current_value` file. However, the
> kernel currently never updates this value in sysfs, preventing users
> from reading the actual metrics.
> 
> This patch series implements the missing logic to align the code
> with the documentation.

Thank you for clarifying, Maksym.

> 
> If the design intent was to intentionally keep `current_value`
> internal and not expose it via sysfs, then the documentation is
> incorrect. Let me know if that's the case, and I will send a v2
> that drops the code changes and only fixes the documentation.

Yes, the documentation is incorrect.  It was written in the way due to
following history.  The DAMOS quota auto-tuning feature was initially developed
with oly 'user_input' target metric type.  In the case, 'current_value' is set
by users.  Hence reading the file was returning the last user-input value.
That is, as the documentation is also saying, it is returning the 'parameter'
(user input) value.  It is not designed for exposing the internal state.

Later we extended the feature to let DAMOS self-fetch the current value.  The
fact that the ``current_value`` is for reading and writing the parameter (user
input) value, and therefore reading it doesn't return the internal set value,
should be further clarified, but I forgot doing that.

So, yes, if the current behavior is not making problem, let's update the
documentation.  I'll wait for your v2 :)

> 
> (Apologies for missing the cover letter where this should have
> been explained, this is my first patch submission).

No worries, we continuously mistake and learn from each other in the
DAMON/mm/linux community!  Welcome to the community, and I'm looking forward to
your v2!


Thanks,
SJ

[...]
