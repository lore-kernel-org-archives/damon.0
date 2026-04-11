Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438930F92D;
	Sat, 11 Apr 2026 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933286; cv=none; b=NMPbFF8uryQQmb6qqOZHFOObz7GzNeVDUBaQfjCZzTjHmnakx6YNJHcpAtpO7FnMjg6jQPgkrTXaoTR29BzcA4quT/pSRUXTehHl/uKzPnaGioeigmqg7YSa2twIYlxCNDcMiq20swZ2vL117b8cl/hzNOgQ3N2bcHxcirc4MOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933286; c=relaxed/simple;
	bh=ApQFbfhxdpo9X8/dqtaLx7tR7B3PkGbN7AFvpjwRHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8VcptQviLz7OivvDntxiifGHckCRpiwgrAPYjTlf3Wz6nAeAU3xX+1GvCUrUOy8Q7QzZn6pf79mvziiaX1N2Sg1u+4WxFqvLR2Ve0xzEbeAur/El4Z1/iCGyKuSdjF1DKsmCa9VtGp5btng81pWvpksdDYIHMFGzabfL9N9yTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg4KsdLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg4KsdLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40770C2BCAF;
	Sat, 11 Apr 2026 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775933285;
	bh=ApQFbfhxdpo9X8/dqtaLx7tR7B3PkGbN7AFvpjwRHTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg4KsdLosaYZ38/xLC7BatDejmVpM2au1eaG/RqiXeSDDFDSrMmm1YZ5RiRUsfhZY
	 T35gc6vhngU9cdWg0/z6tqgO7dCzHfKQFa0O77kMEs1efQJqw7pcva/1ycYx15L05X
	 JEZFUsaueFS5uxtR7LcakzHtfybB61GQ3e0EthNWbAr+JYJHgT2M2uF8Xmog4ZUYFh
	 aMWHEMhOvmEeBx5LE+5Nw0H+DzUjsP8bl1QFbe2zSgQLWE0b6Z1FsB0nKxeDQK4CkE
	 KlAdMmop84FEXC8NGBL0dIXWYcQJQF0QZQgYNMhLjErjAqxjXEyxIRn+7XJ738zl+K
	 FkOdaJH+ZOVsQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] Docs/mm/damon/maintainer-profile: add AI review usage guideline
Date: Sat, 11 Apr 2026 11:48:01 -0700
Message-ID: <20260411184802.81804-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411174906.79491-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# sashiko review suggestions
#
# 1. Consider reducing recipients.  Maybe the author,
#    maintainers, reviewers, and mailing list of the
#    direct subsystem and parent susystem mailing lists
#    could be a starting point.
# 2. Add short summary of your opinion at the beginning.
#    For example:
#
#      TL;DR: sashiko found an issue.  I will respin.
#      TL;DR: sashiko found no issue on this patch.
#
# Please DON'T FORGET removing this comment block before
# sending this!

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260411174906.79491-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit eaf13e650de39668ddb68467088d425fa3e8be04
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/mm/damon/maintainer-profile: add AI review usage guideline
> 
> This commit clarifies how the DAMON maintainer profile uses sashiko.dev for
> AI patch scanning and email delivery. It adds a new AI Review section
> explaining how patch authors can check reviews and share their opinions.
> 
> > diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> > index bcb9798a27a86..5c23b1281c50c 100644
> > --- a/Documentation/mm/damon/maintainer-profile.rst
> > +++ b/Documentation/mm/damon/maintainer-profile.rst
> > @@ -100,3 +100,24 @@ There is also a public Google `calendar
> >  <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
> >  that has the events.  Anyone can subscribe to it.  DAMON maintainer will also
> >  provide periodic reminders to the mailing list (damon@lists.linux.dev).
> > +
> > +AI Review
> > +---------
> > +
> > +For patches that are publicly posted to DAMON mailing list
> > +(damon@lists.linux.dev), AI reviews of the patches will be available at
> > +sashiko.dev.  The reviews could also be sent as mails to the author of the
> > +patch.
> > +
> > +Patch authors are encouraged to check the AI reviews and share their opinions.
> > +The sharing could be done as a reply to the mail thread.  Consider reducing the
> > +recipients list for such sharing, since some people are not really interested
> > +in AI reviews.  As a rule of thumb, drop individuals except DAMON maintainer
> > +and stable@vger.kernel.org from the recipients list.
> 
> Is stable@vger.kernel.org the correct mailing list to keep here?
> 
> The stable mailing list is exclusively for stable kernel backports. Sending
> ongoing patch AI review discussions to that list could result in spamming it.
> Should this perhaps be damon@lists.linux.dev instead?

I mean, drop individuals except DAMON maintainer, and also drop stable@.  I
will wordsmith like below:

'''
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -112,8 +112,8 @@ patch.
 Patch authors are encouraged to check the AI reviews and share their opinions.
 The sharing could be done as a reply to the mail thread.  Consider reducing the
 recipients list for such sharing, since some people are not really interested
-in AI reviews.  As a rule of thumb, drop individuals except DAMON maintainer
-and stable@vger.kernel.org from the recipients list.
+in AI reviews.  As a rule of thumb, drop stable@vger.kernel.org and individuals
+except DAMON maintainer.

 `hkml` also provides a `feature
 <https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
'''

> 
> > +
> > +`hkml` also provides a `feature
> > +<https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
> > +for such sharing.  Please feel free to use the feature.
> > +
> > +It is only a non-mandastory recommendation.  DAMON maintainer could also ask
> 
> This isn't a bug, but there's a typo (non-mandastory) here. It should be
> non-mandatory.

Good eye.  Randy also found [1] this and I already promised to fix.  Sashiko is
better than google doc [2]!

> 
> > +any question about the AI reviews, though.
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260411174906.79491-1-sj@kernel.org

[1] https://lore.kernel.org/20aa1471-5257-4913-ae46-7b40ca0aa128@infradead.org
[2] https://lore.kernel.org/20260411183029.81030-1-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260411174906.79491-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
