Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99646377EA2
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620079; cv=none; b=NtgBToJGTtaf9d9KBf7ZnjDqB7XwiBwjarWyhtdLSQCNsXNZXsPicpb9SBwuu8BVVCmhs2HcwzHwk03UdCcOQ4z+Cs9m2EGjB38NWqWiWohfjNQYKT/oQRCgIvd5Mm1HMR2F5KbZc00nvrH2XJXy1cdCAXfE0W5A71eYZPOCxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620079; c=relaxed/simple;
	bh=jXPocDdR+mB+86+aY90d+DMOG2y40FDcSR2WC5VukBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWpdKH8cQyqEzmQR4+mlO1KPkUdHSfu0yhn3Pf0N0k6s2juzCs0gRY1JG8wJ+1Mo9fuXlaHnm+uK823TLxXTD0IEPCoIKtvDVkVzP8EFtHEJR/zzvxqKQ3IQlCy8/uC05a0pk0Xb7IN3bB1zQ8rIimSENftFkOwKLQ+ccIfxYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYIu9XbV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYIu9XbV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e61ac64ec3so4086905ad.2
        for <damon@lists.linux.dev>; Sat, 10 Oct 2026 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791620077; x=1792224877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HxKJtojMjQnrMJv4R+phcmF7V+2BSeG8Jcmd4MLnyE4=;
        b=oYIu9XbVuhAzind1XZrlpFUOVteNzdvW5TFDeooHrvDkmmMZnlK65lG47N0laczRou
         Cd2K1VZb+Qhc4qJhxDWiboKRExdvGsqvQbRRKut+hZooXIKzQ7sf/2K1CAal6CDyKiwc
         Y5O6pYQvOYYrVQxnGxBPERRprRQWM7KPBQHeJyavvp+KDe+FVe3w4YYdlk3Ppy+InpFu
         r3XmMl0hai8Tt5a7/aednha6cKclb8r3rMeHv2xpA9x6J9T0P8+98lkDjXNruZsOmvFD
         5UJ9yn7GUQSTiGGEeM/bvmoV4mKP+taJaJ2fqti/EgFhoSi5zyb0/95F+WF4zl2I3SvD
         GLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791620077; x=1792224877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HxKJtojMjQnrMJv4R+phcmF7V+2BSeG8Jcmd4MLnyE4=;
        b=vRMtE4TkrxgK5VFSA33+1yvDL8WLeprGB1bX7kydfb3DKDmHznGTbI5j6BEbyLVaYU
         N9ddY/Cd3SqRBA3GO0H36gGDNitr9VcN02kh4U/+BFbIOZ5Kr2u0OAoD4ZX2nPGtlHte
         6O8AuhgqL4AJ+HOOZ//kfA0Cq1JpdluvXv9wiGlDeLNqwZ6frvTPs6NYJ7Gn2xRTcV1R
         ipU7nv8KEuJ6bdZbrYelihL1T1fbZUxHV0aSDl2tTvUQk8mMvRGTeNlv07kBxau28w+X
         svD2IvfBDXTMCFGkf0ItnVET5U1tAygBLsL6V4xcq1Pm7nIwkF4fb9i2sJUXYqJ8a+ui
         yCmQ==
X-Forwarded-Encrypted: i=1; AKwUvByPMvvstJAHytgzglTy50nxHQDAnNOxb5mxIEvXeYBBOLSasvBgq2Wfd91Pxfvcf0m874OjnQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXFVabeP6jPROSjyqNgTaW9zNPwlH7diZE45GQbNerHArzqD+t
	qMJMTm+oox6NGMaSPNEhLEEtVfCxzscBmBAIRPjbWGhQE8xGuopneZrjKcbYXXHY
X-Gm-Gg: AYBFou1PblymLDpEa0auha4jkZN7IQCmAbm/JDmL7l4tjeusYC8B5M4z6rIHPTfolW8
	24iqxgeiEfLiingINtDMnIuIK1mux9IXmVOcxsLvNUIxxRLLyrdErl686JmNZLj3fiMi+oA5gLB
	7asW0ZIYvZt1kv22O1MZ1eJzRYcaduhe+Frjy6DeA89MeQZhekzBacw615Hv2Z6tZMj2BvatZ8d
	x2K1oa5I08LBnm2+cAXk0tema5m9tw9VQGER7VZbg57LNh+pngorPYkvQTia5LgyJX1ctR8fyAO
	Jw4AyFlqJtfW4nsRsYMThbG85uOR+a1C2tOuPHW/SxVdnUQtmqPCPIB7z2Okh7+3mvsBmQV75D6
	r5Gdm/JnpJD6w4MlEUpip8KYrx6MpZqQNif6BI5CnD5SwzL0SQrFjuEv6zhpT4coZUfTnQ4P6eY
	YHgftD1eZsSYQ7cpu7RFeDBI4xGyv2Gx4zOW54PT0QHZFRbfNvM5lFbRJxBhxO568vnCK79J1Fp
	6M=
X-Received: by 2002:a17:902:e54f:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2e842aa7c60mr35565055ad.18.1791620076710;
        Sat, 10 Oct 2026 01:14:36 -0700 (PDT)
Received: from celestia ([2402:1980:896d:5b16:bd84:ae14:d4db:7870])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm21214395ad.4.2026.10.10.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:14:36 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Sat, 10 Oct 2026 16:14:07 +0800
Message-ID: <20261010081453.28212-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009140041.11741-1-sj@kernel.org>
References: <20261009140041.11741-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 07:00:41 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Fri,  9 Oct 2026 20:08:33 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> [...]
> > Yes.  My expected behavior is to completely save and restore the DAMON
> > SYSFS configuration, including DAMOS Schemes.  But it cannot done by
> > 'damo args damon'.
> > 
> > In the script I provided, it first apply lru.json and then uses
> > 'damo args damon' to export the current configuration file.
> 
> 'damo args damon' does not export the running DAMON parameters.  Why do you
> expect so?  Has some document confused you?

Thank you for your clarify.

Actually, there is no any document confused me.  'damo args' section in
USAGE.md is good enough.  I think it is just because I made assumption
about what 'damo args damon' would do.

> 
> > I expected
> > that reapplying this exported configuration (via 'damo start --kdamonds')
> > would fully restore the previous DAMON SYSFS setup.
> 
> So this expectation is wrong.
> 
> > 
> > However, the current/unexpected behavior is that it drops the DAMOS
> > Schemes configuration entirely.  In other words, I cannot fully save
> > and restore the DAMON SYSFS configuration using 'damo args damon'.
> 
> So it looks like there is not problem.  Please let me know if I'm missing
> something.

I will reduce these kinds of false positive from the next time.  At
least, I will state what behavior I expect.

[...]

Best regards,
Rui Yan
