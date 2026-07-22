Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1F41D133
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747773; cv=pass; b=FBXwyldOtVb/MlgeeMvHoilZ+Qcl6NDHe59QmUa8qyuoqztDGtTC8HuRBqE6VdOYgVW/VTVrF7sSxmzIsuhAUTfcvZYodrcKpeX/rCfh439Hn8y8AVwwVXWGytfUovwsp5IrBrlGdhBjNeVM7NzAkt4AE0HTNOS8GxiZG7e05jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747773; c=relaxed/simple;
	bh=uSNJCpAH8uWnp47OfcSugHf++Ebaa9RRjZUksg42xyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcQ7GTINVJSNOWeyNCUaD0lgqSwZ7gc/CAHHwZKRa2KM31Erd4r1iznHCeJsqEJ5cjNxv0cGEtXux4E5WAvTq7egkRdtxrsXDlJ/d+dnTW5d9aDj9n/OlNCQiGMOpCwld6tg6YZEA+XP6yi+4CT4uutxsOein8br32+P5pMOaR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYp2jded; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYp2jded"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso830930a91.3
        for <damon@lists.linux.dev>; Wed, 22 Jul 2026 12:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784747769; cv=none;
        d=google.com; s=arc-20260327;
        b=BMUPiM/jlcI9oxFxCC/Nagtim88/VYVPXUQFp/5Uola3c2Ht3sCyJn8c9MpJ2YPLdp
         lj5OFRIncETt+neONsGhcgqjkWyqCGxK8lItOR21PwxX5d1ZY+I759eEpWorcQY8y8eZ
         H37b5s9/LF93NJE+cCaHkRNAlZk5D9dED1c3RqUV/xQMfFAMFj4Ls328Wrcv5Hof2zKi
         Jv/AAESP3FjwoCd1TgpgtKXZN6WCWBG1H3JKChZNWsPlbmXHyUofxUGTq6lOYy2mXv5f
         HLfIBTU/XCVfUfMHWPO2VrUXH0vz0S0UjMgKwKR6zcxNoChc9hPD7mn68EvRHSzlpg+N
         psAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ozOug//rn4js3ZBhPhRoANd/kYjBAviHldTtDn8NnaE=;
        fh=kZZ7mk801mgukelgTEooQOSh3z9yXIEHMj+94QDl7Bk=;
        b=cMfe4idj1MqFOfJTAUs5p5yM7q9Gxv54AQv1iO10ymcmlPOBrZVnOPJwgduGO4qwyW
         aBu8VStbtr4dc6DfOm64NSl/ZPmwxFUIFcTJV9kkLSmQkM/hVY7yoIwP8n7RhLxrThhd
         fP86SYEgYui+UENYcAA3QFCGEUWnYYBrCChTIDJquYbh06Urt6i/C5w3MEgXqQAY0C4E
         ySkJVQ1x+CMgBL5bke9viLAqnR6sQ+u6ffhP8WNwaw8hOmR0RCi6ejch1xPFCn0diOnT
         IfUQcQPYUYa/0olzrPFKEx6Hts6ua5NM4oUvjih5Eru80n8BoqD1nvRepFJnlaBRz4/X
         8HpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784747769; x=1785352569; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozOug//rn4js3ZBhPhRoANd/kYjBAviHldTtDn8NnaE=;
        b=CYp2jdedAHT7oN9tNwSRAewZe8bYEZxA4sB7IyfC7We2UEdsGcpmA3c0Un6Zf2pQdV
         b3oUkvbPxWnn7JIDAZ4JKtr+lleZwA4uQUfFkGVHaKfTn/zuVoGdMkxSwjCj26qUe4Ou
         h6rYNk2oMcKzIi2eWHZmFqHP0TVHcvBUrFj9dg3HifYujotazIT+TX6zOUH5/aiw5vSm
         jmDI+0PQXjOQHdma5vhELDstQ+Kw+PNlhxZEuPTADjwYkv6Ws7czuQX+5lj2FrN0tk79
         fI7Q88aiIAPbevVNBJsZGyTgT1j/vmlkyx0LdUruswSHpLT9PU4y9s1Ji1IRP8LxSABj
         COhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784747769; x=1785352569;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ozOug//rn4js3ZBhPhRoANd/kYjBAviHldTtDn8NnaE=;
        b=MqDiIryymEdCCPuAwavR4aKs+ZVulVrg01KEAuZ0igRaBoBo3Or88MTHSL5Yi9x8ve
         TRXAgk6X4YTAOJysopUO0XG4ONEWVGydwTznOFxW/bOiSUEoq0xYIUHf6s44NVQxCoLn
         I9eZFeLfx9R5O9rNqABND2Em544Pv1Xc+D9xMmXN77zgB4YXlOy5o3uiEMuL3JVKloOf
         SexYMjvpsetKjbKA9uQ8jkX37OGd2+EEaRnvR3680ViWrpzUKZyX3dDLrNWZ9KcdpMPM
         s9X7ErlSMmxF2UOOuB9QtynBmAnRvaT5rLLtG6PKOl702ie1hmERdYyAx9a1h/SNvhXe
         S7Dg==
X-Forwarded-Encrypted: i=1; AHgh+RoYG3gJ1XcDKhzB+jAX7UhvNTrIRz9o1k9WOqu4rVc+mTNgdxAl+bupnQkHA3VdCDHxS2Bzpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvRlfL2N70sqU5aMiuXaSPuwqmaVCUq0XmhEMWShqOH1W4R4kM
	Dhc2R8rYm1ODIf6nEu6f1nU+fcSLjXjuejry1fGymntegcbMwi2OsNIWalR9GVYFepJxPOTvj/2
	gzb0M18ugI3g78AHwtInzBGCZskyYSvo=
X-Gm-Gg: AR+sD11/NS/aCs3sbm/ZRX0KHGD5K6D1VEv9GjvVscz6i4ieTx2wXZbmPNPNn8JDvbP
	zWTimyu8dS0kB0toaEAHJdREcHXrU4yCGnSwrXkkSvdEurnY0fltW/PoE5yTqA3s3j53jzvIbpc
	z8UrU920DWK/NgKDbrBe4tTtVSkPFOb38lrog5R+taA3FKB1J4TuNJkHWsQVkTcboDTLA3dmde1
	LMmKQcSqMw/U4K8eLtERkBHQzQXLldkgFPNVCPIgNNBFrnsbhlC+Flg9Qp8g+PV1FZ7FdSZkNbH
	ZXlkm8WFNKqlN2Tp
X-Received: by 2002:a05:6a20:258d:b0:39f:a8fb:3354 with SMTP id
 adf61e73a8af0-3c3ad805268mr25896068637.17.1784747768953; Wed, 22 Jul 2026
 12:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260722033844.65932-1-sj@kernel.org> <20260722134812.88133-1-sj@kernel.org>
In-Reply-To: <20260722134812.88133-1-sj@kernel.org>
From: Hari Mishal <harimishal1@gmail.com>
Date: Wed, 22 Jul 2026 21:15:56 +0200
X-Gm-Features: AUfX_mz66IglqNqdzZCfbnWOLo8Vdschk37JvoWGxCkjUKLSNKZYiZ0uUUFwDeg
Message-ID: <CAMmC+=BDZ6thHptTq=yGvfygUQb+0i2QeGbKXH+OFcXpnTXv1A@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/damon/sysfs.py: clean up sh processes used
 for obsolete_target test
To: SJ Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> From the next time, please don't post a new version of a patch as a reply to
> the previous version.  Post a new version as a new thread, with changelogs [1]
> including links to previous revisions.
>
> Also, give others sufficient time, say, one day, to add comments before posting
> a new version.  If someone publicly asked questions to your patch, please
> answer the questions and keep the discussion in public until the discussion is
> clearly completed, before posting a new version.

Got it! Will keep it in mind for next time. Sorry about all the confusion! :)

> > The obsolete_target test spawns three sh processes and uses their pids
> > as DAMON monitoring targets.  These processes are never terminated or
> > waited on, so they are left running (or become zombies) as orphaned
> > children after the test program exits.
> >
> > Terminate each process and communicate() with it after the targets are
> > no longer needed, so it exits and gets reaped instead of being leaked.
>
> Makes sense to me.  Thank you for this patch.

Ofc, happy to contribute!

> >
> > Signed-off-by: Hari Mishal <harimishal1@gmail.com>
>
> Reviewed-by: SJ Park <sj@kernel.org>
>
> > ---
> > v2: Terminate each sh process directly instead of giving it its own
> >     stdin pipe to close, dropping the stdin=PIPE changes and shrinking
> >     the diff.
>
> When you add changelog, please add links to the previous revisions.
>
> Finally, please use mm-new [2] as the baseline of DAMON patches from the next
> time.
>
> This patch is applied to damon/next [2] tree.  If this patch is not added to
> mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
> to pick this.  So, no action from your side is needed for now.  If it seems I
> also forgot doing that or you cannot wait for my action, please feel free to
> directly ask that to Andrew.
>

I'm quite happy to wait! Thanks for your clarity.

> We (mm community) now want to focus on making mm.git more stabilized and
> therefore ready for the next merge window, rather than adding more changes that
> are not really urgent.  I agree and want to help [1] that.  For the reason,
> unless Andre pick this first, I will request adding this to mm.git only after
> next -rc1 release.  Let me know if you think this is really urgent.
>
> [1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org

Definitely don't think it's an urgent change. Anyone who is using a
tool like damon would be able to debug this quite easily.
Thanks for clarity, again.

Accidentally dropped reply all AGAIN, sorry about this. Resending to
make sure everything is public again.
Cheers,
Hari
