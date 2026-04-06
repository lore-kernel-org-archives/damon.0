Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62C18B0A
	for <damon@lists.linux.dev>; Mon,  6 Apr 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490652; cv=none; b=TeVg9qy5ha23ArkRzQI//YqicfGLHoY+mQuoFJF2f3OlBZcCGbpo259/CZ2qlGakroElgKHwp7jxkmsVy9dGWxLN6lrHOsG73KN/Uf7ML8sqKGTQvfoecqJpP+Cnjqv06q1WzMNlJAqTz29lVLtIektpJJ6B6TNRn+Uvbc9YAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490652; c=relaxed/simple;
	bh=tjMRSF1p4+VSnXJtffjcLVXFwq9VwyFQ1AbNrZCxpj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXxA1CpUrDzpNqIQkjXu12MBedcd7XqYv0/cq0Z4iboIiVD0h+ztAvHHWlAF1sWDyMkuh1kdVe+XOpGPas0uawVDxQgqnI9q4RDikNWUZQg1SfCrT/xeCrkH8bx7c9JUkbcDKsdS7dtqXVq+jnOA3YY88DbkFHay4UOuICH3Wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJBaMjfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJBaMjfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38976C4CEF7;
	Mon,  6 Apr 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775490652;
	bh=tjMRSF1p4+VSnXJtffjcLVXFwq9VwyFQ1AbNrZCxpj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJBaMjfodQ2EPymXCu+99Y9+PfziY+f4YLesTvmbV6Guo3XSepQ61uSoyXce528aU
	 aJ0/Nhj9oJJBzdOeCIE2CET/bCGPSO43qdw0eiYNz9YRxVMg0WTYFKZWqQOaaVL3kp
	 TorbCtfAKwTUzdZ97w9yWKumN0uS/MQU2B/YDAR4cXjQaiFBWN3H0nE0k0XtVFIJ6x
	 oWx31gPtoK/Jny6zsSdRTHYUnpzbBIhk9oNiFoblLsb2ruId5aK8BdxpNG66sJi3sd
	 /uYldeun5FU5DVwpAGHFqA+k6H5HZFZ0IWjk1r5TF1ZrhL0U/GPdm1Xv+EquTz6rSh
	 xrlk9L7+QQv5Q==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Mon,  6 Apr 2026 08:50:50 -0700
Message-ID: <20260406155050.47762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406094116.13164-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  6 Apr 2026 17:41:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat,  4 Apr 2026 13:30:43 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Sat,  4 Apr 2026 17:11:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > [...]
> > > I think this deserves Cc stable@ because:
> > > - The issue can be triggered by accidental user misconfiguration
> > > - It causes kdamond termination and hard to recover/restart. Once
> > >   triggered, kdamond remains in an unusable state, and I have not found
> > >   a way to recover/restart it through the sysfs interface without a
> > >   system reboot.
> > > - The fix is small and low-risk
> > > - It improves user experience on stable kernels
> > 
> > Thank you for elaborating this.  I now think this deserves Cc-ing stable@.
> 
> Thank you for agreeing to Cc stable@.
> 
> > Let's make sure the user impact is clearly documented on the commit message.
> > Also, the code change itself and the current commit message is not clearly
> > explaining how the real problem (DAMON cannot be restarted) can happen.  Please
> > add the description in the next revision.
> 
> I will add an explanation of why DAMON cannot be restarted in the next
> revision.
> 
> > [...]
> > 
> > > 
> > > > For stable@ Cc-ing patches, more clearly describing the user impact would be
> > > > nice, and helpful for judging if it deserves that.  Could you please elaborate?
> > > 
> > > I will add a "User Impact" section in v4's commit message:
> > 
> > Yes, please add this kind of message that make clear what is the user impact.
> > 
> > > 
> > >     User Impact
> > >     ===========
> > >     Currently, if a user commit an invalid 'addr_unit', kdamond may
> > >     terminate abruptly. Once terminated, it cannot be easily restarted
> > >     via sysfs, pontentially requiring a system reboot to restore DAMON
> > >     functionality. This patch prevent such termination by validating
> > >     parameters (addr_unit and min_region_sz) early.
> > 
> > You mentioned it cannot be restarted above.  The above message sounds like
> > there is a way to restart it via sysfs, though it is not easy.  Please make it
> > clear and consistent.  As I also requested above, please add the internal
> > mechanism of how that makes restart unable.  This itself doesn't explain it.
> 
> Thank you for your correction. I will make the description clear and
> consistent, and also explain the internal mechanism 
> (the 'maybe_corrupted' flag and why writing to 'enabled' cannot recover
> it).

Sounds all good :)

> 
> Note: 
> Please excuse my slower responses in the coming weeks, as I have
> upcoming exams. I will be most active and able to follow up during
> weekend (Friday/Saturday).

No worries, take your time :)


Thanks,
SJ

[...]
